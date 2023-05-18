int playerX, playerY;
int playerSpeed;
int asteroidX, asteroidY, asteroidR;
int asteroidSpeed;
int score;
int shotX, shotY;
int shotSpeed;

void setup() {
  size(400, 700);
  resetGame();
}

void draw() {
  background(0); // black background
  
  // move player
  if (keyPressed && key == 'w') {
    playerY -= playerSpeed;
  }
  
  if (keyPressed && key == 's') {
    playerY += playerSpeed;
  }
  
  if (keyPressed && key == 'a') {
    playerX -= playerSpeed;
  }
  
  if (keyPressed && key == 'd') {
    playerX += playerSpeed; //
  }
  
  if (keyPressed && key == ' ') {
    shot(playerX, playerY);
  }
  
  asteroidY += asteroidSpeed;
  shotY -= shotSpeed;
  
  if (dist(playerX, playerY, asteroidX, asteroidY) < 20) {
    resetGame();
  }
  
  if (dist(shotX, shotY, asteroidX, asteroidY) < 20) {
    asteroidR = 0;
    asteroidX = height;
    asteroidY = width;
  }
  
  
  if (frameCount % 180 == 0) {
    spawnAsteroid();
  }
  
  fill(255);
  ellipse(playerX, playerY, 20, 20); // player
  ellipse(asteroidX, asteroidY, asteroidR, asteroidR); // asteroid
  ellipse(shotX, shotY, 10, 10); // shot
  
  //score
  textAlign(LEFT);
  fill(255);
  textSize(20);
  text("Score: " + score, 10, 30);
  
  score++;
}

void resetGame() {
  playerX = width/2;
  playerY = height - 50;
  playerSpeed = 5;
  spawnAsteroid();
  
  score = 0;
}

void spawnAsteroid() {
  asteroidX = (int)random(20, width-20);
  asteroidY = -20;
  asteroidSpeed = 4;
  asteroidR = 40;
}

void shot(int playerX, int playerY) {
  shotX = playerX;
  shotY = playerY - 15;
  shotSpeed = 8;
}
