import cv2
from ultralytics import YOLO
import configparser
import numpy as np

### SORT интеграция
from sort import Sort


def make_rtsp_url(cam, cfg):
    ip = cfg[f'camera_{cam}']['ip']
    port = cfg[f'camera_{cam}']['port']
    username = cfg[f'camera_{cam}']['username']
    pwd = cfg[f'camera_{cam}']['password']
    channel = cfg[f'camera_{cam}']['channel']
    subtype = cfg[f'camera_{cam}']['subtype']
    return f'rtsp://{username}:{pwd}@{ip}:{port}/cam/realmonitor?channel={channel}&subtype={subtype}'


def get_line_from_config_ini(cfg):
    sx = cfg.getint('Line', 'start_x')
    ex = cfg.getint('Line', 'end_x')
    thickness = cfg.getint('Line', 'thickness', fallback=4)
    return (sx, 0, ex, 0, thickness)


def is_left_of_line(point, line_start, line_end):
    # >0 е от едната страна, <0 от другата, 0 точно върху нея
    return ((line_end[0] - line_start[0]) * (point[1] - line_start[1]) -
            (line_end[1] - line_start[1]) * (point[0] - line_start[0]))


def count_people():
    global frame
    crossed_counter = 0
    last_left_states = {}
    tracker = Sort(max_age=8, min_hits=2, iou_threshold=0.3)  # Може да коригираш ако имаш нужда

    config_ini = configparser.ConfigParser()
    config_ini.read('config.ini')

    rtsp_url_final = make_rtsp_url(2, config_ini)

    mode = config_ini.get('General', 'mode')
    if mode == 'test':
        print("Тестов режим: Променяй координатите на линията на живо!")

    cap = cv2.VideoCapture(rtsp_url_final)
    model = YOLO("yolov8n.pt")

    while True:
        ret, frame = cap.read()
        if not ret:
            break

            # Вземи актуалните координати (в test режим - на всеки кадър)
        if mode == 'test':
            config_ini.read('config_ini.ini')
        lineconf = get_line_from_config_ini(config_ini)
        sx, sy, ex, ey, thickness = lineconf

        # Вземи височината на кадъра!
        height, width = frame.shape[:2]
        line_start = (sx, 0)
        line_end = (ex, height)

        # Начертай дебела червена линия:
        cv2.line(frame, line_start, line_end, (0, 0, 255), thickness)

        # --- YOLO детектиране ---
        results = model(frame)
        detections = results[0].boxes

        # Събирай само хора, [x1, y1, x2, y2, conf]
        people_dets = []
        for box in detections:
            cls = int(box.cls[0])
            if cls == 0:  # person
                x1, y1, x2, y2 = map(int, box.xyxy[0])
                conf = float(box.conf[0])
                people_dets.append([x1, y1, x2, y2, conf])

                # Форматирай за SORT
        dets_for_sort = np.array(people_dets)
        if len(dets_for_sort) == 0:
            dets_for_sort = np.empty((0, 5))

            # --- SORT TRACKING ---
        tracks = tracker.update(dets_for_sort)

        for track in tracks:
            x1, y1, x2, y2, track_id = track.astype(int)
            left_point = (x1, y1)
            side = is_left_of_line(left_point, line_start, line_end)
            last_side = last_left_states.get(track_id, None)
            if last_side is not None and last_side > 0 and side < 0:
                crossed_counter += 1
                print(f"Обект {track_id} премина линията от ляво надясно! Общо: {crossed_counter}")
            last_left_states[track_id] = side

            # Рисуване на bbox + track_id
            cv2.rectangle(frame, (x1, y1), (x2, y2), (255, 255, 0), 2)
            cv2.putText(frame, f"{track_id}", (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.8, (255, 0, 0), 2)

            # Показва броя на преминалите
        cv2.putText(
            frame,
            f"Crossed: {crossed_counter}",
            (width - 320, height - 80),
            cv2.FONT_HERSHEY_SIMPLEX, 1.4, (0, 0, 255), 3
        )

        cv2.imshow("Camera", frame)
        if cv2.waitKey(1) == ord('q'):
            break
            # в режим live може да излезеш от while True при нужда

    cap.release()
    cv2.destroyAllWindows()


if __name__ == "__main__":
    count_people()