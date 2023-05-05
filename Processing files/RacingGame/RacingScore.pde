public class RacingScore {
  int x, y, player;
  color c;
  int currentLap;
  boolean raceEnded = false;

  RacingScore(int x_, int y_, int player_, color c_) {
    x = x_;
    y = y_;
    player = player_;
    c = c_;
  }

  void update(int lap) {
    currentLap = lap;
  }

  void display() {
    shader(racingBackgroundShader);
    if (currentLap >= 5) {
      textSize(50);
      text("Player " + player + " wins!", width/2, 100);
      raceEnded = true;
    }
    pushMatrix();
    translate(x, y);
    scale(1+ abs(0.2*sin((float)millis()/2000)));
    textSize(35);
    text("Player " + player, 0, 0 - 50);
    textSize(25);
    text("Lap: " + currentLap + "/5", -25, 0);

    resetShader();
    fill(0);
    rect(8+50, 10-10, 5, 5);
    rect(-8+50, 10-10, 5, 5);
    rect(8+50, -10-10, 5, 5);
    rect(-8+50, -10-10, 5, 5);
    fill(c * 2);
    rect(0+50, 0-10, 16, 30);
    fill(c);
    rect(0+50, -3-10, 16, 15);
    popMatrix();
  }

  public boolean getRaceEnded() {
    return raceEnded;
  }
}
