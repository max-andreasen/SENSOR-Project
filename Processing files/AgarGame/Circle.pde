
public class AgarCircle {
  // CLASS VARIABLES
  float x, y, r; 
  int speed = 2;
  
  // CONSTRUCTOR
  AgarCircle(float x_, float y_, float r_) 
  {
    x = x_;
    y = y_;
    r = r_;
  }
  
  // Returns the radius and then sets it to 0 (removing the Circle)
  float remove() 
  {
    float radius = r;
    r = 0;
    return radius;
  }
  
  void move(float speed) 
  {
    y += (speed/(r/25));
  }
  
  // Displays the Circle on screen
  void display() 
  {
    fill(255);
    ellipse(x,y,2*r,2*r);
  }
  
}
