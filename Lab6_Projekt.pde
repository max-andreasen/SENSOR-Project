import processing.serial.*;
import processing.net.*; 

import java.util.List;
import java.util.ArrayList;


Serial myPort;
String val;
boolean firstContact = false;
String[] values;

int x_val = 500; 
int y_val = 500; 
int sw_val;

int score = 0;
int previous_score = -1;

Circle circle_1, circle_2, circle_3, circle_4, circle_5, circle_6;
Player player;

List<Circle> circles = new ArrayList<>();


void setup() {
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n'); //Waits here until it gets the establishContact input.
  
  player = new Player(500, 500, 20, score);
  circle_1 = new Circle(400, 200, 30);
  circle_2 = new Circle(900, 200, 10);
  circle_3 = new Circle(800, 300, 15);
  circle_4 = new Circle(200, 40, 20);
  circle_5 = new Circle(250, 250, 30);
  circle_6 = new Circle(600, 400, 20);
  
  circles.add(circle_1);
  circles.add(circle_2);
  circles.add(circle_3);
  circles.add(circle_4);
  circles.add(circle_5);
  circles.add(circle_6);
  
  println(circles);
  
  size(1000, 1000);
  noStroke(); 
  
  delay(1000);
  
}


void draw() {
  
  background(0,225,149);
  player.update(x_val, y_val);
  player.display();
  
  
  score = player.getScore();
  
  if (firstContact) 
  {
    
    if (score != previous_score) 
    {
      println(score);
      myPort.write(score);
      previous_score = score;
    }

  }
  
  
  for (int i = 0; i < circles.size(); i++) 
  {
    if  (check_collision(player, circles.get(i))) 
    {
      circles.remove(i);
    } 
  }
  
  
  for (int i = 0; i < circles.size(); i++) 
  {
    circles.get(i).display();
  }
  
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
      x_val = Integer.parseInt(values[0]);
      y_val = Integer.parseInt(values[1]);
      sw_val = Integer.parseInt(values[2]);
      
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

boolean check_collision(Player player, Circle obj) {
  if (player.hits(obj)) 
  {
    float radius = obj.remove();
    obj = null;
    player.grow(radius);
    println("YUUMM!!");
    return true;
  }
  else {
    return false;
  }
}
