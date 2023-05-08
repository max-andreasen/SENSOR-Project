public class RacingPlayer {
  int x, y;
  int lap = 1;
  int currentCheckpoint = 1;

  float scale = 1.5;
  float currentAngle = PI;
  float respawnDelay;
  float speed = 2;

  color c;

  PVector front_v, up_v;
  boolean dead = false;

  int[] checkpoint1 = {250, 500};
  int[] checkpoint2 = {500, 250};
  int[] checkpoint3 = {750, 500};
  int[] checkpoint4 = {500, 750};

  RacingPlayer(int x_, int y_, color c_) {
    x = x_;
    y = y_;
    c = c_;
  }

  void update(int x_input, int y_input, int prs_input) {
    if (x_input-511 > 100) {
      x_input = 1;
    } else if (x_input-511 < -100) {
      x_input = -1;
    } else if (x_input-511 > -100 && x_input-511 < 100) {
      x_input = 0;
    }
    
    if (y_input-511 > 100) {
      y_input = 1;
    } else if (y_input-511 < -100) {
      y_input = -1;
    } else if (y_input-511 > -100 && y_input-511 < 100) {
      y_input = 0;
    }
    
    speed = ((float) prs_input / 1023)*6;


    float x_speed = x_input * speed;
    float y_speed = y_input * speed;

    front_v = new PVector(x_speed, y_speed);
    up_v = new PVector(0, 1);
    front_v.normalize();

    x += x_speed;
    y += y_speed;

    if (!inBounds() && !dead) {
      Death();
    }

    if (dead) {
      Respawn();
    }

    Checkpoint();
  }

  void display() {
    resetShader();
    currentAngle = calcAngle();
    pushMatrix();
    translate(x, y);
    scale(scale);
    rotate(-currentAngle);
    fill(0);
    rect(8, 10, 5, 5);
    rect(-8, 10, 5, 5);
    rect(8, -10, 5, 5);
    rect(-8, -10, 5, 5);
    fill(c * 2);
    rect(0, 0, 16, 30);
    fill(c);
    rect(0, -3, 16, 15);
    popMatrix();
  }

  void Checkpoint() {
    if (sqrt(pow(x - checkpoint1[0], 2) + pow(y - checkpoint1[1], 2)) < 80 && currentCheckpoint == 4) {
      currentCheckpoint = 1;
      lap++;
    } else if (sqrt(pow(x - checkpoint2[0], 2) + pow(y - checkpoint2[1], 2)) < 80 && currentCheckpoint == 1) {
      currentCheckpoint = 2;
    } else if (sqrt(pow(x - checkpoint3[0], 2) + pow(y - checkpoint3[1], 2)) < 80 && currentCheckpoint == 2) {
      currentCheckpoint = 3;
    } else if (sqrt(pow(x - checkpoint4[0], 2) + pow(y - checkpoint4[1], 2)) < 80 && currentCheckpoint == 3) {
      currentCheckpoint = 4;
    }
  }

  void Respawn() {
    scale = scale * 0.95;
    if (millis() > respawnDelay) {
      if (currentCheckpoint == 1) {
        x = checkpoint1[0];
        y = checkpoint1[1];
      }
      if (currentCheckpoint == 2) {
        x = checkpoint2[0];
        y = checkpoint2[1];
      }
      if (currentCheckpoint == 3) {
        x = checkpoint3[0];
        y = checkpoint3[1];
      }
      if (currentCheckpoint == 4) {
        x = checkpoint4[0];
        y = checkpoint4[1];
      }
      speed = 2;
      scale = 1.5;
      dead = false;
    }
  }

  void Death() {
    respawnDelay = millis() + 1000;
    speed = 0;
    dead = true;
  }

  boolean inBounds() {
    int localCenterPos_x = x-width/2;
    int localCenterPos_y = y-height/2;
    if (abs(localCenterPos_x) < 160 && abs(localCenterPos_y) < 160) {
      return false;
    }
    if (abs(localCenterPos_x) > 340 || abs(localCenterPos_y) > 340) {
      return false;
    }
    return true;
  }

  float calcAngle() {
    float dot = up_v.dot(front_v);
    float det = front_v.array()[0]*up_v.array()[1] - up_v.array()[0]*front_v.array()[1];
    float angle = atan2(det, dot);
    if (front_v.mag() == 0) {
      return currentAngle;
    }
    return angle;
  }

  public int getLap() {
    return lap;
  }
}
