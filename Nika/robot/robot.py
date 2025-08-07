import configparser
import cv2
import serial

import requests
import tempfile
import os

from ultralytics import YOLO
import numpy as np

### SORT интеграция
from sort import Sort

# Зарежда предварително обучен модел за разпознаване на хора (YOLOv8n е малък и бърз)
model = YOLO('yolov8n.pt')

from Nika.robot.APIclient import RaceClient


def buffer_pump(cam):
    for _ in range(19):
        ret, frame = cam.read()
        if not ret:
            return


def capture_and_upload_athlete_photo(cam, athlete_id, api_base_url, pump_frames=8):
    """
    cam: вече отворен cv2.VideoCapture обект
    athlete_id: int, id на Athlete записа
    api_base_url: напр. "http://localhost:8000"
    # "Изпомпай" буфера
    """
    for _ in range(pump_frames):
        ret, frame = cam.read()
        if not ret:
            print("Проблем с камерата при изкарване на кадри!")
            # return False


    ret, frame = cam.read()
    if not ret:
        print("Неуспешно взимане на кадър от камерата")
        return False
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
    cv2.putText(frame, f"People: {count}", (20, 40),
                cv2.FONT_HERSHEY_SIMPLEX, 1.4, (0,0,255), 3)

    # Създавам временен файл, който няма да се изтрие веднага
    with tempfile.NamedTemporaryFile(suffix=".jpg", delete=False) as tmp_file:
        tmp_filename = tmp_file.name

    try:
        # Записвам снимката (файлът вече е затворен и не е lock-нат)
        cv2.imwrite(tmp_filename, frame)

        url = f"{api_base_url}/api/athletes/{athlete_id}/add_photo/"
        with open(tmp_filename, 'rb') as img:
            files = {'image': img}
            response = requests.post(url, files=files)
    finally:
        # Изтривам файла ръчно
        os.remove(tmp_filename)

    if response.status_code == 201:
        print("Снимката е успешно записана в БД!")
        return True
    else:
        print(f"Грешка при качване: {response.status_code} {response.text}")
        return False


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
    sx = cfg.getint('Line', 'start_x')
    ex = cfg.getint('Line', 'end_x')
    thickness = cfg.getint('Line', 'thickness', fallback=4)
    return (sx, 0, ex, 0, thickness)


def is_left_of_line(point, line_start, line_end):
    # >0 е от едната страна, <0 от другата, 0 точно върху нея
    return ((line_end[0] - line_start[0]) * (point[1] - line_start[1]) -
            (line_end[1] - line_start[1]) * (point[0] - line_start[0]))

# Създаване на парсер и четене на .ini файл - настройки на приложнието
config = configparser.ConfigParser()
config.read('config.ini')

rtsp_url_bib_numbers = make_rtsp_url(1,config)
rtsp_url_final = make_rtsp_url(2, config)

server_url = f'http://{config["server"]["ip"]}:{config["server"]["port"]}'
server_token = config["server"]["token"]

barrier_com = f'COM{config["barrier"]["com_port"]}'

# свързвам се към потоците от камерите
cam_bib = cv2.VideoCapture(rtsp_url_bib_numbers)
cam_final = cv2.VideoCapture(rtsp_url_final)

# иницирам серийния порт за бариерата
ser = serial.Serial(barrier_com, 9600, timeout=1)  # провери точния порт!

race_api = RaceClient(server_url, server_token)
race_api.load_sys_params()

race_api.periodic_sync(sync_interval=1.0)

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
        buffer_pump(cam_final)
        # отчитане на сигнал от бариерата
        line = ser.readline().decode().strip()
        if line == "ACTIVATED":
            print("БАРИЕРА ЗАДЕЙСТВАНА!")
            # Тук – HTTP POST към Django за 'бариера задействана'
            ath = race_api.mark_first_as_finished()
            if ath > 0:
                for i in range(3):
                    capture_and_upload_athlete_photo(cam_final, ath, server_url, 3)

        elif line == "DEACTIVATED":
            print("БАРИЕРА ОСВОБОДЕНА!")
            # Тук – HTTP POST към Django за 'бариера освободена'

print('КРАЙ!')
race_api.stop_sync()
