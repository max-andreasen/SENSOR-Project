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

int buttonLeft = 9;
int buttonRight = 10;

int servoPin = 7;
Servo scoreIndic;

RunningAverageFilter x_filter = RunningAverageFilter();
RunningAverageFilter y_filter = RunningAverageFilter();
RunningAverageFilter z_filter = RunningAverageFilter();
RunningAverageFilter prs_filter = RunningAverageFilter();
RunningAverageFilter rot_filter = RunningAverageFilter();
RunningAverageFilter x_accel_filter = RunningAverageFilter();
RunningAverageFilter y_accel_filter = RunningAverageFilter();
RunningAverageFilter z_accel_filter = RunningAverageFilter();

void displaySensorDetails(void)
{
  sensor_t sensor;
  accel.getSensor(&sensor);
  Serial.println("------------------------------------");
  Serial.print  ("Sensor:       "); Serial.println(sensor.name);
  Serial.print  ("Driver Ver:   "); Serial.println(sensor.version);
  Serial.print  ("Unique ID:    "); Serial.println(sensor.sensor_id);
  Serial.print  ("Max Value:    "); Serial.print(sensor.max_value); Serial.println(" m/s^2");
  Serial.print  ("Min Value:    "); Serial.print(sensor.min_value); Serial.println(" m/s^2");
  Serial.print  ("Resolution:   "); Serial.print(sensor.resolution); Serial.println(" m/s^2");  
  Serial.println("------------------------------------");
  Serial.println("");
  delay(500);
}

void displayDataRate(void)
{
  Serial.print  ("Data Rate:    "); 
  
  switch(accel.getDataRate())
  {
    case ADXL345_DATARATE_3200_HZ:
      Serial.print  ("3200 "); 
      break;
    case ADXL345_DATARATE_1600_HZ:
      Serial.print  ("1600 "); 
      break;
    case ADXL345_DATARATE_800_HZ:
      Serial.print  ("800 "); 
      break;
    case ADXL345_DATARATE_400_HZ:
      Serial.print  ("400 "); 
      break;
    case ADXL345_DATARATE_200_HZ:
      Serial.print  ("200 "); 
      break;
    case ADXL345_DATARATE_100_HZ:
      Serial.print  ("100 "); 
      break;
    case ADXL345_DATARATE_50_HZ:
      Serial.print  ("50 "); 
      break;
    case ADXL345_DATARATE_25_HZ:
      Serial.print  ("25 "); 
      break;
    case ADXL345_DATARATE_12_5_HZ:
      Serial.print  ("12.5 "); 
      break;
    case ADXL345_DATARATE_6_25HZ:
      Serial.print  ("6.25 "); 
      break;
    case ADXL345_DATARATE_3_13_HZ:
      Serial.print  ("3.13 "); 
      break;
    case ADXL345_DATARATE_1_56_HZ:
      Serial.print  ("1.56 "); 
      break;
    case ADXL345_DATARATE_0_78_HZ:
      Serial.print  ("0.78 "); 
      break;
    case ADXL345_DATARATE_0_39_HZ:
      Serial.print  ("0.39 "); 
      break;
    case ADXL345_DATARATE_0_20_HZ:
      Serial.print  ("0.20 "); 
      break;
    case ADXL345_DATARATE_0_10_HZ:
      Serial.print  ("0.10 "); 
      break;
    default:
      Serial.print  ("???? "); 
      break;
  }  
  Serial.println(" Hz");  
}

void displayRange(void)
{
  Serial.print  ("Range:         +/- "); 
  
  switch(accel.getRange())
  {
    case ADXL345_RANGE_16_G:
      Serial.print  ("16 "); 
      break;
    case ADXL345_RANGE_8_G:
      Serial.print  ("8 "); 
      break;
    case ADXL345_RANGE_4_G:
      Serial.print  ("4 "); 
      break;
    case ADXL345_RANGE_2_G:
      Serial.print  ("2 "); 
      break;
    default:
      Serial.print  ("?? "); 
      break;
  }  
  Serial.println(" g");  
}

void setup(void) 
{
  Serial.begin(9600);
  x_filter = RunningAverageFilter();
  y_filter = RunningAverageFilter();
  z_filter = RunningAverageFilter();
  prs_filter = RunningAverageFilter();
  rot_filter = RunningAverageFilter();
  x_accel_filter = RunningAverageFilter();
  y_accel_filter = RunningAverageFilter();
  z_accel_filter = RunningAverageFilter();
  /*
  #ifndef ESP8266
  while (!Serial); // for Leonardo/Micro/Zero
  #endif
  Serial.println("Accelerometer Test"); Serial.println("");

  /* Initialise the sensor 
  if(!accel.begin())
  {
    /* There was a problem detecting the ADXL345 ... check your connections   
    Serial.println("Ooops, no ADXL345 detected ... Check your wiring!");
    while(1);
  }

  Serial.println("HEJ");

  /* Set the range to whatever is appropriate for your project 
  accel.setRange(ADXL345_RANGE_16_G);
  // accel.setRange(ADXL345_RANGE_8_G);
  // accel.setRange(ADXL345_RANGE_4_G);
  // accel.setRange(ADXL345_RANGE_2_G);
  
  /* Display some basic information on this sensor 
  displaySensorDetails();
  
  /* Display additional settings (outside the scope of sensor_t)   
  displayDataRate();
  displayRange();
  Serial.println("");

  */

  scoreIndic.attach(servoPin);
  scoreIndic.write(150);
  pinMode(x_joystick, INPUT);
  pinMode(y_joystick, INPUT);
  pinMode(switch_joystick, INPUT);
  pinMode(buttonLeft, INPUT);
  pinMode(buttonRight, INPUT);
  pinMode(pressure, INPUT);
  pinMode(rotation, INPUT);
  
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

  int rot_reading = analogRead(rotation);
  int rot_average = (int) (rot_filter.getAverage(rot_reading));
  Serial.println(("r") + String(rot_average));

/*
  int bl_reading = digitalRead(buttonLeft);
  int br_reading = digitalRead(buttonRight);
  Serial.println("bl" + String(bl_reading));
  Serial.println("br" + String(br_reading));
  
  /* Get a new sensor event */ 

  /*
  sensors_event_t event; 
  accel.getEvent(&event);
  float x_accel_reading = event.acceleration.x;
  float x_accel_average = x_accel_filter.getAverage(x_accel_reading);
  float y_accel_reading = event.acceleration.y;
  float y_accel_average = y_accel_filter.getAverage(y_accel_reading);
  float z_accel_reading = event.acceleration.z;
  float z_accel_average = z_accel_filter.getAverage(z_accel_reading);
  Serial.println("a" + String(x_accel_average) + "," + String(y_accel_average) + "," + String(z_accel_average));
  */

  if (Serial.available()){
    int sensor = Serial.read();
    int maxScore = 3;
    int angle = (int) 150 - (24.5 + (49*sensor)); 
    scoreIndic.write(angle);
  }
  else 
  {
    scoreIndic.write(150-49);

  }

  delay(10);
}



void establishContact() {
  while (Serial.available() <= 0) {
  Serial.println("A");   // send a capital A
  delay(300);
  }
}