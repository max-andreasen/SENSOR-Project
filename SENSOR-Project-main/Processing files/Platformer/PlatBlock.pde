class PlatBlock {
  PVector pos;
  int blockWidth;
  int blockHeight;
  
  PlatBlock(float x_cord, float y_cord, int block_width, int block_height) {
    pos = new PVector(x_cord,y_cord);
    this.blockWidth = block_width;
    this.blockHeight = block_height;
  }
  void draw() {
    rect(pos.x, pos.y, blockWidth, blockHeight);
  }
  
  boolean checkCollisionFeet(PlatPlayer player){
    if (player.pos.x >= pos.x && player.pos.x <= pos.x + blockWidth && player.feetPos >= pos.y && player.feetPos <= pos.y + blockHeight) {
      return true;
    }
    return false;
  }
  boolean checkCollisionHead(PlatPlayer player){
    if (player.pos.x >= pos.x && player.pos.x <= pos.x + blockWidth && player.pos.y <= pos.y + blockHeight && player.pos.y > pos.y + blockHeight / 2){
      return true;
    }
    
    return false;
  }


}
