const int BARRIER_PIN = 2;
int lastState = HIGH; // При PULLUP - HIGH = незадействано

void setup() {
  pinMode(BARRIER_PIN, INPUT_PULLUP); 
  Serial.begin(9600);
}

void loop() {
  int currentState = digitalRead(BARRIER_PIN);

  // Преход от NE задействана (HIGH) към задействана (LOW)
  if (lastState == HIGH && currentState == LOW) {
    Serial.println("DEACTIVATED"); // Бариера освободена
    delay(20); // debounce
  }

  // Преход от задействана (LOW) към НЕ задействана (HIGH)
  if (lastState == LOW && currentState == HIGH) {
    Serial.println("ACTIVATED"); // Бариера задействана
    delay(20); // debounce
  }

  lastState = currentState;
  delay(2); // Main loop debounce
}