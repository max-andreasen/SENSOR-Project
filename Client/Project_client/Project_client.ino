#include "RunningAverageFilter.h"
#include <Servo.h>
#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_ADXL345_U.h>

/* Assign a unique ID to this sensor at the same time */
Adafruit_ADXL345_Unified accel = Adafruit_ADXL345_Unified(12345);

int x_joystick = A0;
int y_joystick = A1;
int switch_joystick = A2;
int pressure = A5;
int rotation = A4;
int currentSensor = 0;
int currentAngle = 20;


RunningAverageFilter x_filter = RunningAverageFilter();
RunningAverageFilter y_filter = RunningAverageFilter();
RunningAverageFilter z_filter = RunningAverageFilter();
RunningAverageFilter prs_filter = RunningAverageFilter();
RunningAverageFilter rot_filter = RunningAverageFilter();
RunningAverageFilter x_accel_filter = RunningAverageFilter();
RunningAverageFilter y_accel_filter = RunningAverageFilter();
RunningAverageFilter z_accel_filter = RunningAverageFilter();

int servoPin = 7;
Servo scoreIndic;

void setup(void) {

#ifndef ESP8266
  while (!Serial)
    ;  // for Leonardo/Micro/Zero
#endif

  Serial.begin(9600);

  Serial.println("Accelerometer Test");
  Serial.println("");

  if (!accel.begin()) {
    Serial.println("Ooops, no ADXL345 detected ... Check your wiring!");
    while (1) {};
  }

  accel.setRange(ADXL345_RANGE_16_G);
  accel.setRange(ADXL345_RANGE_8_G);
  accel.setRange(ADXL345_RANGE_4_G);
  accel.setRange(ADXL345_RANGE_2_G);

  scoreIndic.attach(servoPin);
  scoreIndic.write(150);
  pinMode(x_joystick, INPUT);
  pinMode(y_joystick, INPUT);
  pinMode(switch_joystick, INPUT);
  pinMode(pressure, INPUT);
  pinMode(rotation, INPUT);

  scoreIndic.write(30);

  establishContact();
}

void loop() {
  // put your main code here, to run repeatedly:
  if (Serial.available()) {
    currentSensor = Serial.read();
    int angle = (int) (30 + (80 * currentSensor));
    scoreIndic.write(angle);
  }
  /*
  if (currentSensor == 0) {
    int x_joystick_reading = analogRead(x_joystick);
    int x_joystick_average = (int)(x_filter.getAverage(x_joystick_reading));

    int y_joystick_reading = analogRead(y_joystick);
    int y_joystick_average = (int)(y_filter.getAverage(y_joystick_reading));

    int switch_joystick_reading = analogRead(switch_joystick);
    int switch_joystick_average = (int)(z_filter.getAverage(switch_joystick_reading));
    Serial.println("j" + String(x_joystick_average) + "," + String(y_joystick_average) + "," + String(switch_joystick_average));
  }
  else if (currentSensor == 1) {

    sensors_event_t event;
    accel.getEvent(&event);
    float x_accel_reading = event.acceleration.x;
    float x_accel_average = x_accel_filter.getAverage(x_accel_reading);
    float y_accel_reading = event.acceleration.y;
    float y_accel_average = y_accel_filter.getAverage(y_accel_reading);
    float z_accel_reading = event.acceleration.z;
    float z_accel_average = z_accel_filter.getAverage(z_accel_reading);
    Serial.println("a" + String(x_accel_average) + "," + String(y_accel_average) + "," + String(z_accel_average));
  }
  */
  int x_joystick_reading = analogRead(x_joystick);
  int x_joystick_average = (int)(x_filter.getAverage(x_joystick_reading));

  int y_joystick_reading = analogRead(y_joystick);
  int y_joystick_average = (int)(y_filter.getAverage(y_joystick_reading));

  int switch_joystick_reading = analogRead(switch_joystick);
  int switch_joystick_average = (int)(z_filter.getAverage(switch_joystick_reading));
  Serial.println("j" + String(x_joystick_average) + "," + String(y_joystick_average) + "," + String(switch_joystick_average));
  
  sensors_event_t event;
  accel.getEvent(&event);
  float x_accel_reading = event.acceleration.x;
  float x_accel_average = x_accel_filter.getAverage(x_accel_reading);
  float y_accel_reading = event.acceleration.y;
  float y_accel_average = y_accel_filter.getAverage(y_accel_reading);
  float z_accel_reading = event.acceleration.z;
  float z_accel_average = z_accel_filter.getAverage(z_accel_reading);
  Serial.println("a" + String(x_accel_average) + "," + String(y_accel_average) + "," + String(z_accel_average) + ",");
  /*
  int prs_reading = analogRead(pressure);
  int prs_average = (int) (prs_filter.getAverage(prs_reading));
  Serial.println(("p") + String(prs_average));
  */

  /*
  else if (currentSensor == 1) {
    int rot_reading = analogRead(rotation);
    int rot_average = (int)(rot_filter.getAverage(rot_reading));
    Serial.println("r" + String(rot_average));
  }*/

  /* Get a new sensor event */



  delay(10);
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println("A");  // send a capital A
    delay(300);
  }
}
