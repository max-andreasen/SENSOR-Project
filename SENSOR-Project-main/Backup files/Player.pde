
public class Player {
  int x, y, r;
  int score;
  
  Player(int x_, int y_, int r_, int score_) 
  {
    x = x_;
    y = y_;
    r = r_;
    score = score_;
  }
  
  
  void update(int x_in, int y_in)
  {
    x += (x_in-500)/100;
    y += (y_in-502)/100;
    
    //println(x);
  }
  
  
  void grow(float rad) 
  {
    r += rad/2;
    score += 1;
  }
  
  int getScore() 
  { 
    return score;
  }
  
  
  boolean hits(Circle other) 
  {
    float d = dist(x, y, other.x, other.y);
    
    if (d < r + other.r) 
    {
      return true;
    } 
    else 
    {
      return false;
    }
    
  }
  
  void display()
  {
    fill(0);
    ellipse(x, y, 2*r, 2*r);
  }
}
