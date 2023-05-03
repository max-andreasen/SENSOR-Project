
public class Circle {
  float x, y;
  float r;
  
  Circle(float x_, float y_, float r_) 
  {
    x = x_;
    y = y_;
    r = r_;
  }
  
  void display() 
  {
    fill(255);
    ellipse(x,y,2*r,2*r);
  }
  
  float remove() 
  {
    float radius = r;
    r = 0;
    return radius;
  }
  
}
