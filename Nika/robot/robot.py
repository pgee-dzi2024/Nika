import configparser
import cv2
import serial

import requests
import tempfile
import os

from ultralytics import YOLO
import numpy as np
from Nika.robot.APIclient import RaceClient

# SORT интеграция
from sort import Sort

# Зарежда предварително обучен модел за разпознаване на хора (YOLOv8n е малък и бърз)
model = YOLO('yolov8n.pt')


"""
        И Н И Ц И А Л И З А З А Ц И Я
"""


def make_rtsp_url(cam, cfg):
    ip = cfg[f'camera_{cam}']['ip']
    port = cfg[f'camera_{cam}']['port']
    username = cfg[f'camera_{cam}']['username']
    pwd = cfg[f'camera_{cam}']['password']
    channel = cfg[f'camera_{cam}']['channel']
    subtype = cfg[f'camera_{cam}']['subtype']
    return f'rtsp://{username}:{pwd}@{ip}:{port}/cam/realmonitor?channel={channel}&subtype={subtype}'


def get_line_from_config_ini(cfg):
    sx_ = cfg.getint('Line', 'start_x')
    ex_ = cfg.getint('Line', 'end_x')
    thickness_ = cfg.getint('Line', 'thickness', fallback=4)
    return sx_, 0, ex_, 0, thickness_


def is_left_of_line(point, line_start_, line_end_):
    # >0 е от едната страна, <0 от другата, 0 точно върху нея
    return ((line_end_[0] - line_start_[0]) * (point[1] - line_start_[1]) -
            (line_end_[1] - line_start_[1]) * (point[0] - line_start_[0]))


# Създаване на парсер и четене на .ini файл - настройки на приложнието
config = configparser.ConfigParser()
config.read('config.ini')

rtsp_url_bib_numbers = make_rtsp_url(1, config)
rtsp_url_final = make_rtsp_url(2, config)

server_url = f'http://{config["server"]["ip"]}:{config["server"]["port"]}'
server_token = config["server"]["token"]

barrier_com = f'COM{config["barrier"]["com_port"]}'

# свързвам се към потоците от камерите
# cam_bib = cv2.VideoCapture(rtsp_url_bib_numbers)
cam_final = cv2.VideoCapture(rtsp_url_final)

# иницирам серийния порт за бариерата
# ser = serial.Serial(barrier_com, 9600, timeout=1)  # провери точния порт!

race_api = RaceClient(server_url, server_token)
race_api.load_sys_params()

race_api.periodic_sync(sync_interval=1.0)

crossed_counter = 0
last_left_states = {}
tracker = Sort(max_age=8, min_hits=2, iou_threshold=0.3)  # Може да коригираш ако имаш нужда


mode = config.get('General', 'mode')

line_conf = get_line_from_config_ini(config)
sx, sy, ex, ey, thickness = line_conf


"""
        ГЛАВЕН ЦИКЪЛ
"""
while race_api.sysParams['status'] < 3:
    #  ако status=3 то състезанието е завършило и няма нужда от робот
    if race_api.sysParams['status'] == 2:
        # ****************************************
        #    С Ъ С Т Е З А Н И Е
        # ****************************************

        # ToDo: да се добави сканиране на номерата на пристигащи състезатели

        ret, frame = cam_final.read()
        if not ret:
            # print('err!!!!')
            break

        # Вземаме височината на кадъра
        height, width = frame.shape[:2]
        line_start = (sx, 0)
        line_end = (ex, height)

        # Начертаваме дебела червена линия:
        cv2.line(frame, line_start, line_end, (0, 0, 255), thickness)

        # --- YOLO детектиране ---
        results = model(frame)
        detections = results[0].boxes

        # Събираме само хора, [x1, y1, x2, y2, conf]
        count = 0
        people_dets = []
        for box in detections:
            cls = int(box.cls[0])
            if cls == 0:  # person
                count += 1
                x1, y1, x2, y2 = map(int, box.xyxy[0])
                conf = float(box.conf[0])
                people_dets.append([x1, y1, x2, y2, conf])
        # Изписваме броя на хората
        h, w = frame.shape[:2]

        # Форматираме за SORT
        dets_for_sort = np.array(people_dets)
        if len(dets_for_sort) == 0:
            dets_for_sort = np.empty((0, 5))

        # --- SORT TRACKING ---
        tracks = tracker.update(dets_for_sort)

        crossed_counter_old = crossed_counter
        for track in tracks:
            x1, y1, x2, y2, track_id = track.astype(int)
            left_point = (x1, y1)
            side = is_left_of_line(left_point, line_start, line_end)
            last_side = last_left_states.get(track_id, None)
            if last_side is not None and last_side < 0 and side > 0:
                crossed_counter += 1
                print(f"Обект {track_id} премина линията от ляво надясно! Общо: {crossed_counter}")
            last_left_states[track_id] = side

            # проверявам дали има нов пресякъл линията
            if crossed_counter>crossed_counter_old:
                ath = race_api.mark_first_as_finished(crossed_counter-crossed_counter_old)
                # Създавам временен файл, който няма да се изтрие веднага
                with tempfile.NamedTemporaryFile(suffix=".jpg", delete=False) as tmp_file:
                    tmp_filename = tmp_file.name

                try:
                    # Записвам снимката (файлът вече е затворен и не е lock-нат)
                    cv2.imwrite(tmp_filename, frame)
                    for athlete_id in ath:
                        url = f"{server_url}/api/athletes/{athlete_id}/add_photo/"
                        with open(tmp_filename, 'rb') as img:
                            files = {'image': img}
                            response = requests.post(url, files=files)
                finally:
                    # Изтривам файла ръчно
                    os.remove(tmp_filename)
            # Рисуване на bbox + track_id
            cv2.rectangle(frame, (x1, y1), (x2, y2), (255, 255, 0), 2)
            cv2.putText(frame, f"{track_id}", (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.8, (255, 0, 0), 2)

            # Показва броя на преминалите
        cv2.putText(frame, f"People: {count}", (w - 300, h - 200),
                    cv2.FONT_HERSHEY_SIMPLEX, 1.4, (255, 0, 0), 3)
        cv2.putText(
            frame,
            f"Crossed: {crossed_counter}",
            (width - 320, height - 80),
            cv2.FONT_HERSHEY_SIMPLEX, 1.4, (0, 0, 255), 3
        )

        cv2.imshow("Camera", frame)
        if cv2.waitKey(1) == ord('q'):
            break

print('КРАЙ!')
race_api.stop_sync()
cam_final.release()
# cam_bib.release()
cv2.destroyAllWindows()