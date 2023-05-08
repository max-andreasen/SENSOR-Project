#include "RunningAverageFilter.h"
#include <Servo.h>

int x_joystick = A0;
int y_joystick = A1;
int switch_joystick = A2;
int pressure = A5;
int buttonLeft = 9;
int buttonRight = 10;


RunningAverageFilter x_filter = RunningAverageFilter();
RunningAverageFilter y_filter = RunningAverageFilter();
RunningAverageFilter z_filter = RunningAverageFilter();
RunningAverageFilter prs_filter = RunningAverageFilter();

int servoPin = 7;
Servo scoreIndic;


void setup(void) 
{
  scoreIndic.attach(servoPin);
  scoreIndic.write(150);
  pinMode(x_joystick, INPUT);
  pinMode(y_joystick, INPUT);
  pinMode(switch_joystick, INPUT);
  pinMode(buttonLeft, INPUT);
  pinMode(buttonRight, INPUT);
  pinMode(pressure, INPUT);
  Serial.begin(9600);
  establishContact();

}

void loop() {
  // put your main code here, to run repeatedly:
  int x_joystick_reading = analogRead(x_joystick);
  int x_joystick_average = (int) (x_filter.getAverage(x_joystick_reading));

  int y_joystick_reading = analogRead(y_joystick);
  int y_joystick_average = (int) (y_filter.getAverage(y_joystick_reading));

  int switch_joystick_reading = analogRead(switch_joystick);
  int switch_joystick_average = (int) (z_filter.getAverage(switch_joystick_reading));
  Serial.println("j" + String(x_joystick_average) + "," + String(y_joystick_average) + "," + String(switch_joystick_average));

  int prs_reading = analogRead(pressure);
  int prs_average = (int) (prs_filter.getAverage(prs_reading));
  Serial.println(("p") + String(prs_average));

  int bl_reading = digitalRead(buttonLeft);
  int br_reading = digitalRead(buttonRight);
  Serial.println("bl" + String(bl_reading));
  Serial.println("br" + String(br_reading));

  if (Serial.available()){
    int score = Serial.read();
    int maxScore = 6;
    int angle = (int) 150-(24.5*score); 
    //scoreIndic.write(angle);
  }

  delay(100);
}



void establishContact() {
  while (Serial.available() <= 0) {
  Serial.println("A");   // send a capital A
  delay(300);
  }
}
