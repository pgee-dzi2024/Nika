import serial

ser = serial.Serial('COM3', 9600, timeout=1)  # провери точния порт!

while True:
    line = ser.readline().decode().strip()
    if line == "ACTIVATED":
        print("БАРИЕРА ЗАДЕЙСТВАНА!")
        # Тук – HTTP POST към Django за 'бариера задействана'
    elif line == "DEACTIVATED":
        print("БАРИЕРА ОСВОБОДЕНА!")
        # Тук – HTTP POST към Django за 'бариера освободена'