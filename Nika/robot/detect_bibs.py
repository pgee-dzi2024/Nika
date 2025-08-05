"""
това изисква обучен модел - оставям го за в бъдеще
"""
import cv2
import time
from ultralytics import YOLO
from paddleocr import PaddleOCR

# Настройки
CROP_TOP = 0.3  # Горна граница за crop - 30% отгоре махаме
CROP_BOTTOM = 0.1  # Долна граница - 10% отдолу махаме
CONF_THRESHOLD = 0.60  # Минимален праг за YOLO bbox confid.
IOU_THRESH = 0.5  # при дебъг: ако два bbox имат над 0.5 припокриване, смятай за един
NOT_SEEN_MAX = 10  # кадъра, след които номерът се “архивира”
SERVER_UPDATE_INTERVAL = 0.5  # през колко секунди пращаме новите номера

START_LIST = {'123', '456', '111', '321', ...}  # вместо set, можеш да ползваш dict за стартовия лист


# Вашият клас със състезатели
class BibNumberEntry:
    def __init__(self, number, bbox, timestamp):
        self.number = number
        self.bbox = bbox  # [x1, y1, x2, y2]
        self.status = 'new'  # 'new', 'processed', 'invalid'
        self.last_seen = timestamp
        self.not_seen_for = 0
        self.match_start_list = number in START_LIST

    def update(self, bbox, timestamp):
        self.bbox = bbox
        self.last_seen = timestamp
        self.not_seen_for = 0


def bbox_iou(boxA, boxB):
    # стандартно IoU за избягване на двойна детекция
    xA = max(boxA[0], boxB[0])
    yA = max(boxA[1], boxB[1])
    xB = min(boxA[2], boxB[2])
    yB = min(boxA[3], boxB[3])

    interArea = max(0, xB - xA) * max(0, yB - yA)
    if interArea == 0:
        return 0.0
    boxAArea = (boxA[2] - boxA[0]) * (boxA[3] - boxA[1])
    boxBArea = (boxB[2] - boxB[0]) * (boxB[3] - boxB[1])
    iou = interArea / float(boxAArea + boxBArea - interArea)
    return iou


# Мейн клас за обработка
class BibNumberDetector:
    def __init__(self, video_source):
        self.yolo = YOLO('път/до/yolov8detrained-on-bibs.pt')
        self.ocr = PaddleOCR(lang='en', use_gpu=True)
        self.entries = []  # списък от BibNumberEntry
        self.last_server_update = 0

        self.cap = cv2.VideoCapture(video_source)

    def process_frame(self, frame):
        h, w, _ = frame.shape
        y1 = int(h * CROP_TOP)
        y2 = int(h * (1 - CROP_BOTTOM))
        cropped = frame[y1:y2, :, :]

        # YOLO inference (само най-сигурните боксове, например единствено bib_number-class)
        result = self.yolo(cropped)[0]
        bib_boxes = []
        for box in result.boxes:
            conf = float(box.conf[0])
            cls = int(box.cls[0])
            # Тук cls == номер на класа за стартов номер (провери при train!)
            if conf > CONF_THRESHOLD:  # Приемаме само confident боксове
                x1, y1b, x2, y2b = [int(x) for x in box.xyxy[0]]
                y1b += y1  # компенсираме crop-инга
                y2b += y1
                bib_boxes.append((x1, y1b, x2, y2b))

        detected = []
        now = time.time()
        for (x1, y1b, x2, y2b) in bib_boxes:
            bib_crop = frame[y1b:y2b, x1:x2]
            ocr_result = self.ocr.ocr(bib_crop, det=False, cls=False)
            if ocr_result and len(ocr_result[0]) > 0:
                bib_number = ocr_result[0][0][0].strip()
                # при нужда - бейзик валидиране (само цифри, дължина и т.н.)
                if bib_number.isdigit():
                    detected.append({'number': bib_number, 'bbox': (x1, y1b, x2, y2b)})

        # обработка за удвояване/нова детекция
        for det in detected:
            already_tracked = False
            for entry in self.entries:
                # ако има близък номер и голям bbox IoU, го ъпдейтни само
                if entry.number == det['number'] and bbox_iou(entry.bbox, det['bbox']) > IOU_THRESH:
                    entry.update(det['bbox'], now)
                    already_tracked = True
                    break
            if not already_tracked:
                # нов участник
                entry = BibNumberEntry(det['number'], det['bbox'], now)
                if not entry.match_start_list:
                    entry.status = 'invalid'
                self.entries.append(entry)

        # За всички entries, които не са видени този кадър – увеличаваме брояча
        for entry in self.entries:
            if now != entry.last_seen:
                entry.not_seen_for += 1

    def get_entries_for_server(self):
        # връща списък от {'number', 'status', ...} – само нови/необработени
        return [{
            'number': e.number,
            'status': e.status,
            'last_seen': e.last_seen,
            'match_start_list': e.match_start_list,
            'bbox': e.bbox
        } for e in self.entries if e.status == 'new']

    def mark_processed(self, numbers):
        # отбелязва номери като 'processed' (напр. след успешно изпращане до сървъра)
        for entry in self.entries:
            if entry.number in numbers:
                entry.status = 'processed'

    def clean_old_entries(self):
        self.entries = [e for e in self.entries if e.not_seen_for <= NOT_SEEN_MAX]

    def run(self):
        while True:
            ret, frame = self.cap.read()
            if not ret:
                break
            self.process_frame(frame)
            now = time.time()

            # изпращане на нови номера към сървъра през определен интервал
            if now - self.last_server_update > SERVER_UPDATE_INTERVAL:
                to_send = self.get_entries_for_server()
                if to_send:
                    # тук прати към сървъра с requests/post или вътрешен callback
                    # напр. requests.post('http://server/api', json=to_send)
                    print('To send:', to_send)
                    self.mark_processed([e['number'] for e in to_send])
                self.last_server_update = now

            self.clean_old_entries()


# ----- MAIN -----
if __name__ == '__main__':
    det = BibNumberDetector('rtsp://admin:gimas1613@192.168.100.201:554/cam/realmonitor?channel=1&subtype=0')
    det.run()