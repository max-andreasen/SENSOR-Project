import java.util.List;
import java.util.ArrayList;
import java.util.Random;
import java.lang.Math;
import processing.sound.*;

// GLOBAL VARIABLES
int agar_score = 0;
int agar_previous_score = -1;

float x_val_p1;
float y_val_p1;

float joyX;
float joyY;

float pressure;

float tiltX;
float tiltY;
float tiltZ;

int canvas_w = 1500;
int canvas_h = 1000;

AgarPlayer player1;
AgarPlayer player2;

int timer;
int sensor_timer_p1;
int sensor_timer_p2;
int delay;
int elapsed_time; 
float speed;

int number_of_sensors = 3;
int p1_sensor;
int p2_sensor;

boolean firstContact; 
boolean new_game = true; 
boolean game_running = true;

List<AgarCircle> agar_circles = new ArrayList<>();

// CONSTANTS
int CIRCLE_START_Y = -30;
int[] P1_X_BOUND = {0, 730};
int[] P2_X_BOUND = {770, 1500};



// SETUP
void agarSetup() {
  
  timer = 0;
  sensor_timer_p1 = 0;
  sensor_timer_p2 = 0;
  delay = 1500;
  speed = 2;
  elapsed_time = 0;

  
  player1 = new AgarPlayer(canvas_w/4, canvas_h-300, 15, 0, P1_X_BOUND, "Player 1");
  player2 = new AgarPlayer(3000, canvas_h-300, 15, 0, P2_X_BOUND, "Player 2");
  
  p1_sensor = 0;
  p2_sensor = 0;

  noStroke(); 
  
  //delay(1000);
}



// GAME LOOP
void agarDraw(){
  
  if (new_game == true) 
  {
    new_game = false;
    agarSetup();
  }
  
  background(0,225,149);
  rect(740, 0, 40, 1000);
  
  player1.display();
  
  
  // Checks if any player has lost the game
  if (gameOver(player1, player2, canvas_w))
  {
    game_running = false;
    stopSound(music_player); 
  }
  
  // The GAME
  if (game_running) 
  {
    
    // Starts the music, YEAH!
    if (music_playing == false) {
      SoundFile music_player = playSound(music, music_path, music_vol);
      loopSound(music_player);
      music_playing = true;
    }
    
    // Handles the sensor for player 1
    if (p1_sensor != 0 && sensor_timer_p1 < 1000) 
    {
      sensor_timer_p1 += 10;
    }
    else if (sensor_timer_p1 >= 10000)
    {
      sensor_timer_p1 = 0;
      p1_sensor = 0;
    }
    
    // Handles the sensor for player 2
    if (p2_sensor != 0 && sensor_timer_p2 < 10000) 
    {
      sensor_timer_p2 += 10;
      println(sensor_timer_p2);
    }
    else if (sensor_timer_p2 >= 10000)
    {
      sensor_timer_p2 = 0;
      p2_sensor = 0;
      println("Player 2 now back to joystick!");
    }
    
    // Gathers the inputs from the sensor
    float[] sensor_values = sensorValue(p1_sensor);
    x_val_p1 = sensor_values[0];
    y_val_p1 = sensor_values[1];
    
    // Updates the player positions
    player1.update(x_val_p1, y_val_p1);
    
    
    // Updates the List with new Circle positions
    agar_circles = refreshCircles(agar_circles, speed);
    
    speed = calcSpeed(elapsed_time);
    delay = calcDelay(elapsed_time);
    
    
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
    
    player1.addScore();
    player2.addScore();
    
    player1.displayScore();
    player2.displayScore();
    elapsed_time += 10;
  }
  
}



// Spawns a Circle in each player's canvas
void spawnCircles() {
  
  int rand_int = randInt(0,100);
  int type;
  
  if (rand_int < 6) 
  {
    type = 1;
  }
  else if (rand_int == 10) 
  {
    type = 2;
  }
  else 
  {
    type = 0;
  }
  
  AgarCircle new_circle_p1 = createCircle(P1_X_BOUND, type);
  AgarCircle new_circle_p2 = createCircle(P2_X_BOUND, type);
  agar_circles.add(new_circle_p1);
  agar_circles.add(new_circle_p2);
}

void setup() 
{
  size(1500, 1000);
}
void draw() 
{
  agarDraw();
}
