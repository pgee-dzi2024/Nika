import cv2
from ultralytics import YOLO

# Зарежда предварително обучен модел за разпознаване на хора (YOLOv8n е малък и бърз)
model = YOLO('yolov8n.pt')

# Стартира видео камерата (0 == първа свързана USB камера)
cap = cv2.VideoCapture(0)

while True:
    ret, frame = cap.read()
    if not ret:
        print("Грешка с камерата!")
        break

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

    cv2.imshow("People Counter", frame)

    # Спира с натискане на клавиш q
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()