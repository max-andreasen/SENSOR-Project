import processing.serial.*;
import processing.net.*; 

import java.util.List;
import java.util.ArrayList;

boolean run_new_game = true;

Serial myPort;
String val;
boolean firstContact = false;
String[] values;

int joy_x_val = 500; 
int joy_y_val = 500; 
int joy_sw_val;



void setup() {
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n'); //Waits here until it gets the establishContact input.
  size(1000, 1000);
}


void draw() {
  //Spel här:
  agarDraw();
}


void serialEvent(Serial myPort) {
  
  //put the incoming data into a String - 
  //the '\n' is our end delimiter indicating the end of a complete packet
  val = myPort.readStringUntil('\n');
  //make sure our data isn't empty before continuing
  //println(val);
  if (val != null) 
  {
    //trim whitespace and formatting characters (like carriage return)
    val = trim(val);
    //println(val);
  
    //look for our 'A' string to start the handshake
    //if it's there, clear the buffer, and send a request for data
    if (firstContact == false) 
    {
      if (val.equals("A")) 
      {
        myPort.clear();   
        firstContact = true;
        myPort.write("A");
        println("contact");
      }
    }
  
   
    
    else 
    { //if we've already established contact, keep getting and parsing data
      values = val.split(",");
      // when you've parsed the data you have, ask for more:
      //myPort.write("A");
      joy_x_val = Integer.parseInt(values[0]);
      joy_y_val = Integer.parseInt(values[1]);
      joy_sw_val = Integer.parseInt(values[2]);
      
      //println(x_val);
      
     }
   
   }
    /*
    if(!otherNode.active()){
      //delay(1000);
      background(255);  // show graphically that we are not connected
      println("trying to connect");
      otherNode = new Client(this, "130.229.128.85", 2224);
      }
      */
    //otherNode.write("X: " + values[0] + "Y: " + values[1] + "Z: " + values[2]);
    /*
    otherNode.write(val);
    String read = otherNode.readString();
    if (read != null) {
      println(read);
    }
    */
   
   
}
