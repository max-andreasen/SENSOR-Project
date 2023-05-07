class PlatBullet {
  PVector pos;
  int dir;
  int [] colorValues;
  private int size = 10;
  
  PlatBullet(PVector position, int direction, int[] colorValues){ //direction left = -1, right = 1
    dir = direction;
    if (dir == -1) {
      pos = position.add(new PVector(-size + 1, 20)); //In order to not have the player collide with its own bullet.
    }
    if (dir == 1) {
      pos = position.add(new PVector(20 + size, 20)); //Where 20 is the players width.
    }
    pos = position;
    this.colorValues = colorValues;  
  }
  
  
  private void move() {
    pos.x += 10 * dir;
  }
  void draw(){
    move();
    fill(colorValues[0], colorValues[1], colorValues[2]);
    circle(pos.x, pos.y , size);
    fill(256, 256, 256);
    
  }
  
  boolean checkCollision(PlatPlayer player){
      /*
    if (player.pos.x >= pos.x && player.pos.x <= pos.x + size * 2 && player.pos.y <= pos.y + size * 2 && player.pos.y > pos.y) {
        return true;
      } */
      
      if (pos.x >= player.pos.x && pos.x <= player.pos.x + player.playerWidth && pos.y <= player.pos.y + player.playerHeight && pos.y > player.pos.y) {
        return true;
      }
    return false;
  }
}
