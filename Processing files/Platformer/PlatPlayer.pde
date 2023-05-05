class PlatPlayer {
  PVector pos;
  private int playerWidth = 20;
  private int playerHeight = 40;
  private float gravityModifier;
  int[] colorValues;
  boolean isGrounded = false;
  boolean recentlyJumped = false; //Sometimes it would set gravityModifier to 0 again before actually jumping.
  float feetPos;
  
  PlatPlayer(float xCord, float yCord, int[] colorValues) {
    pos = new PVector(xCord,yCord);
    this.colorValues = colorValues;
    feetPos = yCord + playerHeight;
    gravityModifier = 1.0f;
  }
  private void gravity() {
    pos.y += 5 * gravityModifier;
    increaseGravityMod();
    //recentlyJumped = false;
  }
  
  private void increaseGravityMod(){
    if (gravityModifier < 2){
      gravityModifier += 0.05; //In order to have the player accelerate.
    }
  }
  
  void draw() {
    gravity();
    feetPos = pos.y + playerHeight;
    fill(colorValues[0], colorValues[1], colorValues[2]);
    rect(pos.x, pos.y, playerWidth, playerHeight, 10); //the fifth parameter is how rounded the corners are.
    fill(256, 256, 256);
  }
  
  void setGrounded(boolean b){
    isGrounded = b;
    if (b){ 
      gravityModifier = 0.0f;
    }
    
  }
  /*
  void collisionX(){
  
  }*/
  

  void move(PVector direction) {
    pos.add(direction);
  }


  void jump(){
    if (isGrounded){
      isGrounded = false;
      //recentlyJumped = true;
      gravityModifier = -2.0f;
      println("Jump");
    }
    
  }
}
