import configparser
import cv2
import serial

from Nika.robot.APIclient import RaceClient

"""
        ИНИЦИАЛИЗАЗАЦИЯ
"""

def make_rtsp_url(cam):
    ip = config[f'camera_{cam}']['ip']
    port = config[f'camera_{cam}']['port']
    username = config[f'camera_{cam}']['username']
    pwd = config[f'camera_{cam}']['password']
    channel = config[f'camera_{cam}']['channel']
    subtype = config[f'camera_{cam}']['subtype']
    return f'rtsp://{username}:{pwd}@{ip}:{port}/cam/realmonitor?channel={channel}&subtype={subtype}'

# Създаване на парсер и четене на .ini файл - настройки на приложнието
config = configparser.ConfigParser()
config.read('config.ini')

rtsp_url_bib_numbers = make_rtsp_url(1)
rtsp_url_final = make_rtsp_url(2)

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

race_api.periodic_sync(sync_interval=2.0)

"""
        ГЛАВЕН ЦИКЪЛ
"""
while race_api.sysParams['status']<3:
#  ако status=3 то състезанието е завършило и няма нужда от робот
    if race_api.sysParams['status'] == 2:
        print(race_api.format_timer())
print('КРАЙ!')
race_api.stop_sync()
