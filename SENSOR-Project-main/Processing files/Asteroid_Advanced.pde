import java.util.ArrayList;

Asteroid a;
Player p;
Shot s;
ArrayList <Asteroid> asteroids;
ArrayList <Shot> shots;
int spawnTimer = (int)random(0, 100);
int score;



void setup() {
  size(400, 700);
  resetGame();
}

void draw() {
  background(255);
  
  if (spawnTimer == 0) {
    createAsteroid();
    spawnTimer = (int)random(0, 100);
  }
  
  p.update();
  p.display();
  
  if (asteroids.size() != 0){
    for (int i = 0; i < asteroids.size(); i++) {
      Asteroid element = asteroids.get(i);
      element.display();
      element.update();
      
      if (dist(p.x, p.y, element.x, element.y) < element.diameter - 10){
        resetGame();
      }
      
      if (element.y == height){
        resetGame();
      }
      
    }
  }
    
  for (int j = 0; j < shots.size(); j++) {
    Shot shot = shots.get(j);
    shot.display();
    shot.update();
    
    for (int i = 0; i < asteroids.size(); i++) {
      Asteroid element = asteroids.get(i);
    
      if (dist(shot.x, shot.y, element.x, element.y) < element.diameter - 10){
        asteroids.remove(element);
        score ++;
      }
    }
  }
  
  if (p.cd == 0){
    if (keyPressed && key == ' ') {
      createShot();
      p.cd = 20;
    }
  }
  
  //score
  textAlign(LEFT);
  fill(170);
  textSize(20);
  text("Score: " + score, 10, 30);
  
  spawnTimer -= 1;
  if (p.cd > 0){
    p.cd -= 1;
  }
}

void createAsteroid(){
  a = new Asteroid(random(20, width - 20), -20 , random(20, 60), 5);
  asteroids.add(a);
}

void createShot(){
  float shotx = p.wherex();
  float shoty = p.wherey();
  s = new Shot(shotx, shoty, 10, -10);
  shots.add(s);
}

void resetGame(){
  p = new Player(width/2, height-50, 20, 10, 10);
  asteroids = new ArrayList<Asteroid>();
  shots = new ArrayList<Shot>();
  createAsteroid();
  score = 0;
}

class Asteroid {
  float x, y, diameter, speed;

  Asteroid(float x, float y, float diameter, float speed) {
    this.x = x;
    this.y = y;
    this.diameter = diameter;
    this.speed = speed;
  }

  void update() {
    y += speed;
  }

  void display() {
    ellipse(x, y, diameter, diameter);
  }
}

class Player {
  float x, y, diameter, speed, cd;

  Player(float x, float y, float diameter, float speed, float cd) {
    this.x = x;
    this.y = y;
    this.diameter = diameter;
    this.speed = speed;
    this.cd = cd;
  }

  void update() {
    if (keyPressed && key == 'w') {
      y -= speed;
    }
  
    if (keyPressed && key == 's') {
      y += speed;
    }
  
    if (keyPressed && key == 'a') {
      x -= speed;
    }
  
    if (keyPressed && key == 'd') {
      x += speed;
    }
  }
  
  void display() {
    ellipse(x, y, diameter, diameter);
  }
  
  public float wherex() {
    return x;
  }
  
  public float wherey() {
    return y;
  }
}

class Shot {
  float x, y, diameter, speed;

  Shot(float x, float y, float diameter, float speed) {
    this.x = x;
    this.y = y;
    this.diameter = diameter;
    this.speed = speed;
  }

  void update() {
    y += speed;
  }
  
  void display() {
    ellipse(x, y, diameter, diameter);
  }
}
