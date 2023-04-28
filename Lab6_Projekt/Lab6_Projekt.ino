#include "RunningAverageFilter.h"
#include <Servo.h>

int x_joystick = A0;
int y_joystick = A1;
int switch_joystick = A2;
RunningAverageFilter x_filter = RunningAverageFilter();
RunningAverageFilter y_filter = RunningAverageFilter();
RunningAverageFilter z_filter = RunningAverageFilter();

int servoPin = 7;
Servo scoreIndic;


void setup(void) 
{
  scoreIndic.attach(servoPin);
  pinMode(x_joystick, INPUT);
  pinMode(y_joystick, INPUT);
  pinMode(switch_joystick, INPUT);
  Serial.begin(9600);
  //establishContact();
}

void loop() {
  // put your main code here, to run repeatedly:
  int x_joystick_reading = analogRead(x_joystick);
  float x_joystick_average = x_filter.getAverage(x_joystick_reading);

  int y_joystick_reading = analogRead(y_joystick);
  float y_joystick_average = y_filter.getAverage(y_joystick_reading);

  int switch_joystick_reading = analogRead(switch_joystick);
  float switch_joystick_average = z_filter.getAverage(switch_joystick_reading);
  Serial.println("X:" + String(x_joystick_average) + " Y: " + String(y_joystick_average) + " SW: " + String(switch_joystick_average));


  
  delay(100);
}



void establishContact() {
  while (Serial.available() <= 0) {
  Serial.println("A");   // send a capital A
  delay(300);
  }
}
