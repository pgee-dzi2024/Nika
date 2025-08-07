import cv2
from ultralytics import YOLO
import configparser

def make_rtsp_url(cam):
    ip = config[f'camera_{cam}']['ip']
    port = config[f'camera_{cam}']['port']
    username = config[f'camera_{cam}']['username']
    pwd = config[f'camera_{cam}']['password']
    channel = config[f'camera_{cam}']['channel']
    subtype = config[f'camera_{cam}']['subtype']
    return f'rtsp://{username}:{pwd}@{ip}:{port}/cam/realmonitor?channel={channel}&subtype={subtype}'


def get_line_from_config(cfg):
    sx = cfg.getint('Line', 'start_x')
    ex = cfg.getint('Line', 'end_x')
    return (sx, 0, ex, 0)


def count_athletes():
    # YOLO връща списък 'detections'
    results = model(frame)
    detections = results[0].boxes

    # Взимаме само 'person' (клас 0 при COCO)
    count = 0
    for box in detections:
        cls = int(box.cls[0])
        if cls == 0:  # 0 == person в YOLOv8 COCO
            count += 1
            # Рисува квадрат около човека
            x1, y1, x2, y2 = map(int, box.xyxy[0])
            cv2.rectangle(frame, (x1, y1), (x2, y2), (0,255,0), 2)

    # Изписва броя на хората
    h, w = frame.shape[:2]
    cv2.putText(frame, f"People: {count}", (w-300, h-100),
                cv2.FONT_HERSHEY_SIMPLEX, 1.4, (255,0, 0), 3)


mode = '*'   # важно!

# Създаване на парсер и четене на .ini файл - настройки на приложнието
config = configparser.ConfigParser()
config.read('config.ini')

rtsp_url_final = make_rtsp_url(2)

mode = config.get('General', 'mode')
if mode == 'test':
    print("Тестов режим: Можеш да сменяш координатите на линията в config.ini и ще се виждат в реално време!")


# Зарежда предварително обучен модел за разпознаване на хора (YOLOv8n е малък и бърз)
model = YOLO('yolov8n.pt')

# свързвам се към потока от камерата
cap = cv2.VideoCapture(rtsp_url_final)

while True:
    ret, frame = cap.read()
    if not ret:
        print("Грешка с камерата!")
        break

    if mode == 'test':
        config.read('config.ini')
        line = get_line_from_config(config)
    else:
        if 'line' not in locals():
            line = get_line_from_config(config)
    # Draw the line
    thickness = config.getint('Line', 'thickness', fallback=4)
    height, width = frame.shape[:2]
    cv2.line(frame, (line[0], 0), (line[2], height), (0, 0, 255), thickness)

    count_athletes()
    cv2.imshow("People Counter", frame)
    # Спира с натискане на клавиш q
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()


cv2.destroyAllWindows()