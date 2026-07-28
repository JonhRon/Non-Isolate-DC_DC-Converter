#define PWM 6
#define VF A0

void setup() {
  TCCR0B = TCCR0B & B11111000 | B00000001;  // for PWM frequency of 62500.00 Hz
  pinMode(PWM, OUTPUT);
  pinMode(VF, INPUT);
  Serial.begin(9600);
  analogWrite(PWM, 10);
  delay(500);
}

void loop() {
  float feedBack = analogRead(VF);
  float V_f = map(feedBack, 0, 1023, 0, 100000) / 10.0;
  analogWrite(PWM, 30);
  Serial.print("FeedBack Voltages: ");
  Serial.print(V_f);
  Serial.println();
  delay(10);
}
