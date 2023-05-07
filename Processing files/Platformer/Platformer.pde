ArrayList <PlatBlock> platforms;
ArrayList <PlatBullet> bullets;
PlatPlayer[] players;

PlatPlayer player1; 
boolean aPressed = false;
boolean dPressed = false;
boolean wPressed = false;
boolean qPressed = false;
boolean ePressed = false;


void PlatSetup() {
  platforms = new ArrayList<PlatBlock>();
  bullets = new ArrayList<PlatBullet>();
  players = new PlatPlayer[2];
  players[0] = new PlatPlayer(690, 700, new int[]{256, 0, 0});
  players[1] = new PlatPlayer(210, 300, new int[]{0, 256, 0});
  
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

  
  textSize(100);
  
  run_new_game = false;

}


void PlatDraw() {
  
  if (run_new_game){ //If this is the first PlatDraw of the new game.
    PlatSetup();
  }
  
  background(0);
  boolean gameOver= false;
  if (players[0].lives > 0 && players[1].lives > 0) {
    for (PlatPlayer player: players) {
      boolean playerDied = playerCheck(player);
      if (playerDied) {break;} //otherwise both players don't reset their position.
    }
    
    text(Integer.toString(players[0].lives), 800, 100);
    text(Integer.toString(players[1].lives), 100, 100);

  }
  else if (players[0].lives <= 0){
    PlatEndGame("Player 1");
    gameOver = true;
  }
  else {
    PlatEndGame("Player 2");
    gameOver = true;
  }
  if (!gameOver){
    for (PlatPlayer player: players) {player.draw();}
  }
  
}



boolean playerCheck(PlatPlayer player) {
  
  boolean playerDied = false;
  
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
  
  
  PVector moveDir = new PVector();
  if (player.leftPressed){
    moveDir.x = -5;
  }
  else if (player.rightPressed){
    moveDir.x = 5;
  }
  if (player.jumpPressed){
    player.jump();
    player.jumpPressed = false;
  }
  
  if (player.shootLeft){
     bullets.add(new PlatBullet(player.pos.copy(), -1, player.colorValues)); //Using copy since otherwise the bullet would update to the players position each frame, thus following the player.
     player.shootLeft = false;
     player.frameShootCD = 21;
  }
  else if (player.shootRight){ //else if so that you can't shoot in both directions at the same time.
    bullets.add(new PlatBullet(player.pos.copy(), 1, player.colorValues));
    player.shootRight = false;
    player.frameShootCD = 11; //So that you can't just hold the button down and shoot every frame.
   }
   
  

  for (PlatBullet bullet: bullets){
      bullet.draw();
  }
  
 

  
  player.move(moveDir);
  player.gravity();
  if (player.frameShootCD > 0) {
    player.frameShootCD -= 1;
  }
  
  
  for (PlatBullet bullet: bullets) {
    if(bullet.checkCollision(player)){
      player.lives -= 1;
      players[0].pos = new PVector(690, 700);
      players[1].pos = new PVector(210, 300);
      playerDied = true;
      break;
    }
  }
  return playerDied;
}



void PlatEndGame(String winner){
  text((winner + " won!"), 200, 500);
  
  //Set current game to menu again!
  currentGame = 0;
}


//Temporary for keyboard debugging:

void keyPressed() {
  if (key == 'a') {
    players[0].leftPressed = true;
  }
  else if (key == 'd') {
    players[0].rightPressed = true;
  }
  
  else if (key == 'w'){
    players[0].jumpPressed = true;
  }
  else if (key == 'f' && players[0].frameShootCD <= 0){
    players[0].shootLeft = true;
  }
  else if (key == 'g' && players[0].frameShootCD <= 0){
    players[0].shootRight = true;
  }
  
  if (key == 'j') {
    players[1].leftPressed = true;
  }
  else if (key == 'l') {
    players[1].rightPressed = true;
  }
 
  else if (key == 'i'){
    players[1].jumpPressed = true;
  }
  else if (key == 'ö'  && players[1].frameShootCD <= 0){
    players[1].shootLeft = true;
  }
  else if (key == 'ä' && players[1].frameShootCD <= 0){
    players[1].shootRight = true;
  }
  
}

void keyReleased(){
  if (key == 'a'){
      players[0].leftPressed = false;
  }
    if (key == 'd'){
      players[0].rightPressed = false;
  }
    if (key == 'j'){
      players[1].leftPressed = false;
  }
    if (key == 'l'){
      players[1].rightPressed = false;
  }
}
