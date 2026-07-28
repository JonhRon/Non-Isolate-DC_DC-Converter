#define PWM 6
int pwr = 0;
long prevT = 0;
float eprev = 0;
float eintegral = 0;
void setup() {
  pinMode(PWM, OUTPUT);
  pinMode(A0, INPUT);
  Serial.begin(9600);
  Serial.setTimeout(10);
  TCCR0B = TCCR0B & B11111000 | B00000001;  // for PWM frequency of 62500.00 Hz
  analogWrite(PWM,5);
  delay(500);

}

void loop() {
  float Vf = analogRead(A0);
  long currT = micros();
  float deltaT = ((float)(currT - prevT)) / 1.0e6;
  prevT = currT;
  float V_f = map(Vf,0,1023,0,100000)/10.0;
  float Vsp = 1590.00;  // Setpoint Voltage 24V ADC 25415.50
  float kp = 0.01;
  float ki = 0.005;
  float kd = 0.0;
  float e = Vsp-V_f ;
  eintegral = eintegral + e * deltaT;
  float dedt = (e - eprev) / (deltaT);
  float u = kp * e + ki * eintegral + kd * dedt;
  pwr = fabs(u);
  eprev = e;
  if (pwr > 255) pwr = 255;
  if (pwr < 5) pwr = 5;
  analogWrite(PWM,pwr);

  //----------Print-Data---------
  // Serial.print(e);  
  // Serial.print(", ");
  Serial.print(pwr);  
  Serial.print(", ");
  Serial.print("3500.0");  // Maximum Data
  Serial.print(", ");
  Serial.print("0");
  Serial.print(", ");
  Serial.print("1564.00");
  Serial.print(", ");
  Serial.print(V_f);  // Feed Back Voltage
  Serial.println();
}
