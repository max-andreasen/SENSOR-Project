

// Function to extract a random int in a set range
int randInt(int low, int up) {
  Random rand_obj = new Random();
  
  int int_random = rand_obj.nextInt(low, up);
  return int_random;
}

// Checks if a circle and the Player is colliding
boolean checkCollision(AgarPlayer player, AgarPlayer other_player, AgarCircle circle) {
  if (player.hits(circle)) 
  {
    float radius = circle.remove();
    
    if (circle.type == 1)
    {
      player.heal(radius);
      SoundFile sfx_heal = playSound(heal_sfx, heal_path, sfx_vol);
    }
    else if (circle.type == 2) 
    {
      switchSensor(other_player);
      SoundFile sfx_scramble = playSound(scramble_sfx, scramble_path, sfx_vol);
    }
    else
    {    
      player.grow(radius);
    }
    circle = null;
    return true;
  }
  else 
  {
    return false;
  }
}

// Switches the input sensor for the other player
void switchSensor(AgarPlayer player)
{
  
  if (player.getPlayer() == "Player 1") 
  {
    p1_sensor = 1;
  }
  else 
  {
    p2_sensor = 1;
  }
  
  println("NEW SENSOR for " + player.getPlayer() + ": " + 1);
}

// Handles all the action of the circles
List<AgarCircle> refreshCircles(List<AgarCircle> circ_list, float speed) {
  
  // The player objects are taken from the global variables defined in 'AgarGame'
  
  // If the circles array is not empty
  if (circ_list.size() != 0) 
  {
    // Loops through all existing Circles
    for (int i = 0; i < circ_list.size(); i++) 
    {
      AgarCircle next_circle = circ_list.get(i);
      
      // Moves the Circle
      next_circle.move(speed);
      
      // Checks for collision between Player1 and Circle
      if  ((checkCollision(player1, player2, next_circle)) || (checkCollision(player2, player1, next_circle)))
      {
        circ_list.remove(i);
      } 
      
      // Remove the Circle if it moves out of the canvas
      if (next_circle.y >= 1200) 
      {
        next_circle = null;
        circ_list.remove(i);
      }
      
      // Displayes the circles
      if (next_circle != null) 
      {
        next_circle.display();
      }

    }
  }
  
  else 
  {
   // Debug
  }
  
  return circ_list;
}


// Creates a new circle at a random x_position
AgarCircle createCircle(int[] bounds, int type) {
  // Is it better to use a boolen to determine which side to spawn it on? 
  
  int y_pos = CIRCLE_START_Y;
  int x_pos;
  
  // Takes -40 to compensate for the maximum radius of the circle (so it doesn't spawn outside of the boundaries)
  x_pos = randInt(bounds[0], bounds[1]-40);
  
  int radius = randInt(5, 40);
  AgarCircle new_Circle = new AgarCircle(x_pos, y_pos, radius, type);
  return new_Circle;
}

// Checks if player has lost the game
boolean gameOver(AgarPlayer player1, AgarPlayer player2, int wid) {
  
  if (player1.r >= (wid/4)-20) 
  {
    println("Player 2 WINS!!");
    return true;
  }
  else if (player2.r >= (wid/4)-20) 
  {
    println("Player 1 WINS!!");
    return true;
  }
  else 
  {
    return false;
  }
}

// Calculates the delay as a function of the elapsed time 
int calcDelay(int time) {
  
  int min_delay = 250;
  
  double delay = (100000/(Math.sqrt(time+1)));
  int delay_int = (int) delay;
  
  if (delay_int <= min_delay) {
    return min_delay;
  }
  
  else {
    return delay_int;
  }
  
}

// Calculates the speed as a function of elapsed time
float calcSpeed(int time) {
  
  float startvalue = 5;
  float power = (float) (1+ Math.log(Math.log(time/1000)));
  
  float speed = (float) (Math.pow((startvalue*(Math.log(time))/20), power));
  
  
  return speed;
  
}

float[] sensorValue(int sensor_type, String playernr){
  
  float [] values; 
  float mx = mouseX;
  float my = mouseY;
  
  if (sensor_type == 0) 
  {
    if (playernr == "p1") {
    values = new float[]{joyX_p1, joyY_p1};
    }
    else {
    values = new float[]{joyX_p2, joyY_p2};
    }
   
  

}
  else if (sensor_type == 1) 
  {
    if (playernr == "p1") {
      values = new float[]{accelX_p1, accelY_p1};
    }
    else {
      values = new float[]{accelX_p2, accelY_p2};
    }

}
  else 
  {
    return new float[]{mouseX, mouseY};
  }
  
  return values;
}
