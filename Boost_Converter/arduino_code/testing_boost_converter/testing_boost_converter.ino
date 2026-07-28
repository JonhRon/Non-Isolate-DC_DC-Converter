#define PWM 6
void setup() {
  Serial.begin(9600);
  pinMode(PWM, OUTPUT);
  pinMode(A0, INPUT);
  TCCR0B = TCCR0B & B11111000 | B00000001;  // for PWM frequency of 62500.00 Hz
}

void loop() {
  analogWrite(PWM, 250);  // 31 PWM is 48V // 15
  float Vf = analogRead(A0);
  float V_f = map(Vf,0,1023,0,100000)/10.0;

  Serial.print("Analog_Read: ");
  Serial.print(Vf);
  Serial.print(", ");
  Serial.print("Analog_Convert: ");
  Serial.print(V_f);
  Serial.print(", ");
  Serial.println();
  delay(1);
}
