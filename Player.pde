

class Player {
  float x, y, r;
  
  Player(float x_, float y_, float r_) 
  {
    x = x_;
    y = y_;
    r = r_;
  }
  
  void update()
  {
    
    // Reads the string from the port
    if (myPort.available() > 0) 
    {
    val = myPort.readStringUntil('\n');
    }
    // removes all the values = null
    if (val != null) 
    {
      String[] values = val.split(",");
      if (values.length == 2) {
        values[1] = values[1].trim();
      
        x = int(values[0]);
        y = int(values[1]);
      }
      
    }
    
  }
  
  void grow(float rad) {
    r += rad/2;
  }
  
  
  boolean hits(Circle other) {
    float d = dist(x, y, other.x, other.y);
    
    if (d < r + other.r) {
      return true;
    } 
    else {
      return false;
    }
  }
  
  void display(){
    fill(250);
    ellipse(x, y, 2*r, 2*r);
  }
}
