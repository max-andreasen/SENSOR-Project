ArrayList <PlatBlock> platforms;
ArrayList <PlatBullet> bullets;
PlatPlayer[] players;

PlatPlayer player1; 
boolean aPressed = false;
boolean dPressed = false;
boolean wPressed = false;
boolean qPressed = false;
boolean ePressed = false;

void setup() {
  platforms = new ArrayList<PlatBlock>();
  bullets = new ArrayList<PlatBullet>();
  players = new PlatPlayer[2];
  players[0] = new PlatPlayer(210, 700, new int[]{256, 0, 0});
  players[1] = new PlatPlayer(690, 700, new int[]{0, 256, 0});
  
  platforms.add(new PlatBlock(200, 425 , 600, 20));
  platforms.add(new PlatBlock(600, 150, 150, 20));
  platforms.add(new PlatBlock(250, 250, 250, 20));
  platforms.add(new PlatBlock(900, 600 , 100, 20));
  platforms.add(new PlatBlock(0, 600, 100, 20));
  platforms.add(new PlatBlock(750, 750, 150, 20));
  platforms.add(new PlatBlock(100, 750 , 150, 20));
  platforms.add(new PlatBlock(350, 800 , 300, 20));
  platforms.add(new PlatBlock(-1000, 950, 3000, 20));
  rect(100, 200, 30, 44);
  size(1000, 1000);

}

void playerCheck(PlatPlayer player) {
  for (PlatBlock platform: platforms){
    if (platform.checkCollisionFeet(player)){
      player.setGrounded(true);
      player.pos.y = platform.pos.y - player.playerHeight; //Instead of putting the gravity to 0, this sometimes caused the player to phase through the floor.
      break; //Otherwise it will always setGrounded(false) as long as it isn't the last platform in the loop.
    }
    /*
    else if (platform.checkCollisionHead(player1)){
      player1.pos.y = platform.pos.y;
      player1.setGrounded(false);
    } */
    else {
      player.setGrounded(false);
    }
  }
  for (PlatBlock platform: platforms){
    platform.draw();
  }
  
  println(player.isGrounded);
  
  PVector moveDir = new PVector();
  if (aPressed){
    moveDir.x = -5;
  }
  else if (dPressed){
    moveDir.x = 5;
  }
  if (wPressed){
    player.jump();
    wPressed = false;
  }
  
  if (qPressed){
     bullets.add(new PlatBullet(player.pos.copy(), -1, player.colorValues)); //Using copy since otherwise the bullet would update to the players position each frame, thus following the player.
     qPressed = false;
  }
  if (ePressed){
    bullets.add(new PlatBullet(player.pos.copy(), 1, player.colorValues));
    ePressed = false;
  }
  
  for (PlatBullet bullet: bullets){
      bullet.draw();
  }
 

  
  player.move(moveDir);
  player.gravity();
  player.draw();

}


void draw() {
  background(0);
  
  for (PlatPlayer player: players) {
  playerCheck(player);
  
  }
  /*
  for (PlatBlock platform: platforms){
    if (platform.checkCollisionFeet(players[0])){
      players[0].setGrounded(true);
      players[0].pos.y = platform.pos.y - players[0].playerHeight; //Instead of putting the gravity to 0, this sometimes caused the player to phase through the floor.
      break; //Otherwise it will always setGrounded(false) as long as it isn't the last platform in the loop.
    }

    else {
      players[0].setGrounded(false);
    }
  }
  for (PlatBlock platform: platforms){
    platform.draw();
  }
  
  println(players[0].isGrounded);
  
  PVector moveDir = new PVector();
  if (aPressed){
    moveDir.x = -5;
  }
  else if (dPressed){
    moveDir.x = 5;
  }
  if (wPressed){
    players[0].jump();
    wPressed = false;
  }
  
  if (qPressed){
     bullets.add(new PlatBullet(players[0].pos.copy(), -1, players[0].colorValues)); //Using copy since otherwise the bullet would update to the players position each frame, thus following the player.
     qPressed = false;
  }
  if (ePressed){
    bullets.add(new PlatBullet(players[0].pos.copy(), 1, players[0].colorValues));
    ePressed = false;
  }
  
  for (PlatBullet bullet: bullets){
      bullet.draw();
  }
 

  
  players[0].move(moveDir);
  players[0].gravity();
  players[0].draw();
  */
  
  players[1].gravity();
  players[1].draw();
  //new PlatBullet().draw();
}




void keyPressed() {
  if (key == 'a') {
    aPressed = true;
  }
  else if (key == 'd') {
    dPressed = true;
  }
  
  else if (key == 'w'){
    wPressed = true;
  }
  else if (key == 'q'){
    qPressed = true;
  }
  else if (key == 'e'){
    ePressed = true;
  }
  
}

void keyReleased(){
  if (key == 'a'){
    aPressed = false;
  }
    if (key == 'd'){
    dPressed = false;
  }
}
