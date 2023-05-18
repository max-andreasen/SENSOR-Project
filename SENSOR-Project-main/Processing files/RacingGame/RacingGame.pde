import java.util.*;

RacingPlayer racing_player1;
RacingPlayer racing_player2;

RacingScore racing_score_player1;
RacingScore racing_score_player2;

RacingTrack racing_track;

PShader racingBackgroundShader;
PShader racingFinishShader;

color racing_player1_c = color(200, 200, 255); //BLUE
color racing_player2_c = color(255, 200, 200); //RED


void racingSetup() {

  rectMode(CENTER);
  textAlign(CENTER);
  textMode(SHAPE);
  noStroke();

  racingBackgroundShader = loadShader("racingRainbowShader.frag");
  racingBackgroundShader.set("u_resolution", float(width), float(height));

  racingFinishShader = loadShader("racingBackgroundShader.frag");
  racingFinishShader.set("u_resolution", float(width), float(height));

  racing_track = new RacingTrack();

  racing_player1 = new RacingPlayer(220, 555, racing_player1_c);
  racing_player2 = new RacingPlayer(280, 555, racing_player2_c);

  racing_score_player1 = new RacingScore(100, 120, 1, racing_player1_c);
  racing_score_player2 = new RacingScore(900, 120, 2, racing_player2_c);
}


void racingDraw() {
  if (run_new_game) {
    racingSetup();
    run_new_game = false;
  }

  racingBackgroundShader.set("u_time", (float) millis() / 1000);
  racingFinishShader.set("u_time", (float) millis() / 1000);
  filter(racingFinishShader);
  racing_track.display();

  //racing_player2.update(joy_x_val, joy_y_val);
  //racing_player2.display();
  racing_player1.update(joy_x_val, joy_y_val, prs_val);
  racing_player1.display();

  racing_score_player1.update(racing_player1.getLap());
  //racing_score_player2.update(racing_player2.getLap());
  racing_score_player1.display();
  //racing_score_player2.display();

  if (racing_score_player1.getRaceEnded() || racing_score_player2.getRaceEnded()) {
    racing_player1.speed = 0;
    racing_player2.speed = 0;
    racing_player1.scale *= 0.95;
    racing_player2.scale *= 0.95;
  }
}
//KEYBOARD INPUT

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      joy_y_val = 0;
    } else if (keyCode == RIGHT) {
      joy_x_val = 1023;
    } else if (keyCode == DOWN) {
      joy_y_val = 1023;
    } else if (keyCode == LEFT) {
      joy_x_val = 0;
    }
  }
  if (key == ' ') {
    prs_val = 1023;
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      joy_y_val = 511;
    } else if (keyCode == RIGHT) {
      joy_x_val = 511;
    } else if (keyCode == DOWN) {
      joy_y_val = 511;
    } else if (keyCode == LEFT) {
      joy_x_val = 511;
    }
  }
  if (key == ' ') {
    prs_val = 0;
  }
}
