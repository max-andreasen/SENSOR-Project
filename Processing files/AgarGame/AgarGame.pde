import java.util.List;
import java.util.ArrayList;
import java.util.Random;
import java.lang.Math;

// GLOBAL VARIABLES
int agar_score = 0;
int agar_previous_score = -1;

int mx;
int my;

int canvas_w = 1500;
int canvas_h = 1000;

AgarPlayer player1;
AgarPlayer player2;

int timer;
int delay;
int elapsed_time; 
float speed;

boolean firstContact; 
boolean run_new_game = true; 
boolean game_running;

List<AgarCircle> agar_circles = new ArrayList<>();

// CONSTANTS
int CIRCLE_START_Y = -30;
int[] P1_X_BOUND = {0, 730};
int[] P2_X_BOUND = {770, 1500};



// SETUP
void setup() {
  run_new_game = false;
  
  size(1500, 1000);
  
  timer = 0;
  delay = 1500;
  speed = 2;
  elapsed_time = 0;

  
  player1 = new AgarPlayer(canvas_w/4, canvas_h-300, 15, 0, P1_X_BOUND);
  player2 = new AgarPlayer(3000, canvas_h-300, 15, 0, P2_X_BOUND);

  noStroke(); 
  
  game_running = true;
  delay(1000);
}



// GAME LOOP
void draw(){
  background(0,225,149);
  rect(740, 0, 40, 1000);
  
  player1.display();
  
  // Checks if any player has lost the game
  if (gameOver(player1, player2, canvas_w))
  {
    game_running = false;
  }
  
  // The GAME
  if (game_running) 
  {
    
    mx = mouseX;
    my = mouseY;
    
    player1.update(mx, my);
    
    
    // Handles the circles
    agar_circles = Circles(agar_circles, speed);
    
    speed = calcSpeed(elapsed_time);
    delay = calcDelay(elapsed_time);
    
    // Here we put all the information that is to be written to the Serial Port
    // firstContact is needed to avoid bug in info sent to the serial port
    if (firstContact) 
    {
      scoreCounter(player1, player2);
    }
    
    // A delay for spawning circles
    if (delay > timer) 
    {
      timer += 100;
    }
    // Resets the spawn-timer 
    else 
    {
      timer = 0;
      spawnCircles();
    }
    
    elapsed_time += 10;
  }
  
}

// Spawns a Circle in each player's canvas
void spawnCircles() {
  
  AgarCircle new_circle_p1 = createCircle(P1_X_BOUND);
  AgarCircle new_circle_p2 = createCircle(P2_X_BOUND);
  agar_circles.add(new_circle_p1);
  agar_circles.add(new_circle_p2);
  
}
