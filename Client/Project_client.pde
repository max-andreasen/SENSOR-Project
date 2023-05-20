import processing.net.*; 
import processing.serial.*;
Client otherNode;

Serial myPort;
boolean firstContact = false;
String val;
String data_send;

void setup() { 
  size (300, 100);  
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n'); //Waits here until it gets the establishContact input.
  otherNode = new Client(this, "130.229.172.112", 2402);
} 

void draw() { 
   
  if(!otherNode.active())
  {
    delay(1000);
    background(255);  // show graphically that we are not connected
    println("trying to connect");
    otherNode = new Client(this, "130.229.172.112", 2402);
  }
  
  if (data_send != null) 
  {
    otherNode.write(data_send);
  }
  
  // Current sensor
  String read = otherNode.readString();
  if (read != null) 
  {
    myPort.write(read);
  }
  // ... the rest is as before
}

void serialEvent(Serial myPort) {

  //put the incoming data into a String -
  //the '\n' is our end delimiter indicating the end of a complete packet
  val = myPort.readStringUntil('\n');
  //make sure our data isn't empty before continuing
  if (val != null)
  {
    //trim whitespace and formatting characters (like carriage return)
    val = trim(val);


    //look for our 'A' string to start the handshake
    //if it's there, clear the buffer, and send a request for data
    if (firstContact == false)
    {
      if (val.equals("A"))
      {
        myPort.clear();
        firstContact = true;
        myPort.write("A");
        println("Arduino contact");
      }
    } else
    { //if we've already established contact, keep getting and parsing data
      data_send = val;

      // when you've parsed the data you have, ask for more:
      //myPort.write("A");
    }
  }
}
