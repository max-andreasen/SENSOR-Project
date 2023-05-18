import processing.net.*; 
Server thisNode;
Client otherNode;

int lastValue = 0;

void serverSetup(){
  thisNode = new Server(this, 2402); 
}

void serverEvent(Server someServer, Client someClient) {
  println("We have a new client: " + someClient.ip());
  otherNode = someClient; // We can use this to send message to the client later.
}

// This is called every time a new message is received.
void clientEvent(Client client) {
  val_p2 = client.readString(); // The argument `client` is the node that has sent this node a message.
  println("received from " + client.ip() + " " + val_p2 + " "); // Print the message for debugging
  
  if (val_p2 != null) 
  {
    if (val_p2.charAt(0) == 'j') // Joystick
        {
          val_p2 = val_p2.substring(1);
          values_p2 = val_p2.split(",");
          
          joyX_p2 = Float.parseFloat(values_p2[0]);
          joyY_p2 = Float.parseFloat(values_p2[1]);
        } else if (val_p2.charAt(0) == 'a') // Accelerometer
        {
          val_p2 = val_p2.substring(1);
          values_p2 = val_p2.split(",");
  
          accelX_p2 = Float.parseFloat(values_p2[0]);
          accelY_p2 = Float.parseFloat(values_p2[2]);
          //accelZ = Float.parseFloat(values[1]);
        }
  }
  

  //client.write("hej" + "\n"); // Send the other node (client). We assume that the client expects a string.
}

/*
void serverLoop() {
  // We can display the last received value here, or perform some calculation. Maybe play a sound?
  background(255); // Or change the background color
}*/
