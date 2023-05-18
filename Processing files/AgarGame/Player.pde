

public class AgarPlayer {

  // CLASS VARIABLES
  float x, y;
  int score, prev_score, r;
  int [] bounds;
  int min_r = 10;
  String which_player;

  // CONSTRUCTOR
  AgarPlayer(float x_, float y_, int r_, int score_, int[] bounds_, String player_)
  {
    x = x_;
    y = y_;
    r = r_;
    score = score_;
    bounds = bounds_;
    which_player = player_;
  }

  String getPlayer()
  {
    return which_player;
  }
  
  int getSensor() {
    if (which_player == "Player 1") 
    {
      return p1_sensor;
    }
    else {
      return p2_sensor;
    }
  }

  // Updates the position of the player
  void update(float x_in, float y_in)
  {
    int bound_min = bounds[0]+r;
    int bound_max = bounds[1]-r;
    
    int sensor = getSensor();
    
    if (sensor == 0) 
    {
      x += (x_in-511)/50;
      y += (y_in-511)/50;
    } 
    else if (p1_sensor == 1) {
      x += x_in;
      y += y_in;
      
    } 
    
    x = constrain(x, bound_min, bound_max);
  }

  // Grows the player in size
  void grow(float radius)
  {
    r += radius/4;
  }

  void heal(float radius)
  {
    int heal_factor = 2;
    // Checks so that the player isn't too small
    if ( (r-(radius/heal_factor)) >= min_r )
    {
      r -= radius/heal_factor;
    } else
    {
      r = min_r;
    }
  }

  void addScore()
  {
    score += 1;
  }

  void displayScore()
  {
    fill(0);
    String score_text = Integer.toString(score);
    textSize(40);
    text(score_text, bounds[1]-150, 70);
  }


  // Checks if player hits an object
  boolean hits(AgarCircle circle)
  {
    float d = dist(x, y, circle.x, circle.y);

    if (d < r + circle.r)
    {
      return true;
    } else
    {
      return false;
    }
  }

  // Displays the Player on screen
  void display()
  {
    fill(0);
    ellipse(x, y, 2*r, 2*r);
  }
}
