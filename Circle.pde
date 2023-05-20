
public class AgarCircle {
  // CLASS VARIABLES
  float x, y, r; 
  int speed = 2;
  int type;
  
  // CONSTRUCTOR
  AgarCircle(float x_, float y_, float r_, int type_) 
  {
    x = x_;
    y = y_;
    r = r_;
    type = type_;
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
    y += ( (5*speed) / Math.sqrt(r)  );
  }
  
  // Displays the Circle on screen
  void display() 
  {
    
    if (type == 0) 
    {
      fill(255);
      ellipse(x,y,2*r,2*r);
    }
    else if (type == 1)
    { 
      fill(30,144,255);
      ellipse(x,y,2*r,2*r);
      
      fill(255);
      rect(x-(r/1.7), y-(r/6), r*1.2, r/4.5);
    }
    else if (type == 2) 
    {
      fill(240,240,100);
      ellipse(x,y,2*r,2*r);
      
      fill(105,105,105);
      textSize(r*1.7);
      text("?", x-(r/2.5), y+(r/1.8));
      
      fill(255);
      textSize(r*1.7);
      text("?", x-(r/2.7), y+(r/2), 20);
    }
    fill(255);
  }
  
}
