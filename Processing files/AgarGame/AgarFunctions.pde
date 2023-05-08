

// Function to extract a random int in a set range
int randInt(int low, int up) {
  Random rand_obj = new Random();
  
  int int_random = rand_obj.nextInt(low, up);
  return int_random;
}

// Checks if a circle and the Player is colliding
boolean checkCollision(AgarPlayer player, AgarCircle circle) {
  if (player.hits(circle)) 
  {
    float radius = circle.remove();
    
    if (circle.type == 1)
    {
      player.heal(radius);
    }
    else if (circle.type == 2) 
    {
      switchSensor(player);
    }
    else
    {    
      player.grow(radius);
      println("YUUMM!!");
    }
    circle = null;
    return true;
  }
  else {
    return false;
  }
}

// Switches the input sensor for the other player
void switchSensor(AgarPlayer player)
{
  int rand_int = randInt(0, number_of_sensors+1);
  println("NEW SENSOR: " + rand_int + " for " + player.getPlayer());
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
      if  ((checkCollision(player1, next_circle)) || (checkCollision(player2, next_circle)))
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
    println("No circles in array");
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

// Handles the score and writes it to the Serial port
void scoreCounter(AgarPlayer p1, AgarPlayer p2) {
  int score1 = p1.getScore();
  int score2 = p2.getScore();
  
  int prev_score1 = p1.getPrev();
  int prev_score2 = p2.getPrev();
  
  // Writes the score to the Serial Port if it changes
  if (score1 != prev_score1) 
    {
      println(score1);
      //myPort.write(agar_score);
    }
  if (score2 != prev_score2) 
    {
      println(score1);
      //myPort.write(agar_score);
    }
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
  
  //println("Speed" + speed);
  
  return speed;
  
}
