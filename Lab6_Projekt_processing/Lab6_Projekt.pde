import processing.serial.*;
import processing.net.*; 


Serial myPort;
String val;
boolean firstContact = false;
String[] values;
String x_value;


void setup() {
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n'); //Waits here until it gets the establishContact input.
  
  size (300, 100);
  //otherNode = new Client(this, "130.229.128.85", 2224);   
}

void draw() {
}

void serialEvent( Serial myPort) {
//put the incoming data into a String - 
//the '\n' is our end delimiter indicating the end of a complete packet
val = myPort.readStringUntil('\n');
//make sure our data isn't empty before continuing

  
if (val != null) {
  //trim whitespace and formatting characters (like carriage return)
  val = trim(val);
  //println(val);

  //look for our 'A' string to start the handshake
  //if it's there, clear the buffer, and send a request for data
  if (firstContact == false) {
    if (val.equals("A")) {
      myPort.clear();   
      firstContact = true;
      myPort.write("A");
      println("contact");
    }
  }
 
  
  else { //if we've already established contact, keep getting and parsing data
    values = val.split(",");
    //x_value = values[0];
    // when you've parsed the data you have, ask for more:
    myPort.write("A");
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
   delay(100);
   
    
  }
