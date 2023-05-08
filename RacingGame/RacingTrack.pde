public class RacingTrack {
  int[] roadPosTop = {0, -250};
  int[] roadPosLeft = {-250, 0};
  int[] roadPosBottom = {0, 250};
  int[] roadPosRight = {250, 0};
  
  int[] roadSize = {650, 150};

  void display() {
    //OUTLINES
    pushMatrix();
    translate(width/2, height/2);
    scale(1);
    
    resetShader();
    fill(255);
    rect(roadPosTop[0], roadPosTop[1], roadSize[0] + 15, roadSize[1] + 20);
    rect(roadPosLeft[0], roadPosLeft[1], roadSize[1] + 20, roadSize[0] + 15);
    rect(roadPosBottom[0], roadPosBottom[1], roadSize[0] + 15, roadSize[1] + 20);
    rect(roadPosRight[0], roadPosRight[1], roadSize[1] + 20, roadSize[0] + 15);

    //TRACK
    shader(racingBackgroundShader);
    rect(roadPosTop[0], roadPosTop[1], roadSize[0], roadSize[1]);
    rect(roadPosLeft[0], roadPosLeft[1], roadSize[1], roadSize[0]);
    rect(roadPosBottom[0], roadPosBottom[1], roadSize[0], roadSize[1]);
    rect(roadPosRight[0], roadPosRight[1], roadSize[1], roadSize[0]);

    //STARTLINES
    resetShader();
    fill(0, 0, 0, 50);
    rect(-250, 0, 150, 15); //BIG STARTLINE
    rect(-280, 25, 25, 5); //SMALL STARTLINE (LEFT)
    rect(-220, 25, 25, 5); //SMALL STARTLINE (RIGHT)
    popMatrix();
  }
}
