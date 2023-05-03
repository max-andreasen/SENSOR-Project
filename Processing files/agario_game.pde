
int agar_score = 0;
int agar_previous_score = -1;

AgarCircle agar_circle_1, agar_circle_2, agar_circle_3, agar_circle_4, agar_circle_5, agar_circle_6;
AgarPlayer agar_player;

List<AgarCircle> agar_circles = new ArrayList<>();


void agarSetup(){
  run_new_game = false;
  
  agar_player = new AgarPlayer(500, 500, 20, agar_score);
  agar_circle_1 = new AgarCircle(400, 200, 30);
  agar_circle_2 = new AgarCircle(900, 200, 10);
  agar_circle_3 = new AgarCircle(800, 300, 15);
  agar_circle_4 = new AgarCircle(200, 40, 20);
  agar_circle_5 = new AgarCircle(250, 250, 30);
  agar_circle_6 = new AgarCircle(600, 400, 20);
  
  agar_circles.add(agar_circle_1);
  agar_circles.add(agar_circle_2);
  agar_circles.add(agar_circle_3);
  agar_circles.add(agar_circle_4);
  agar_circles.add(agar_circle_5);
  agar_circles.add(agar_circle_6);
  
  println(agar_circles);
  

  noStroke(); 
  
  delay(1000);
}

void agarDraw(){
  if (run_new_game){
    agarSetup();
  }
  
  background(0,225,149);
  agar_player.update(joy_x_val, joy_y_val);
  agar_player.display();
  
  
  agar_score = agar_player.getScore();
  
  if (firstContact) 
  {
    
    if (agar_score != agar_previous_score) 
    {
      println(agar_score);
      myPort.write(agar_score);
      agar_previous_score = agar_score;
    }

  }
  
  
  for (int i = 0; i < agar_circles.size(); i++) 
  {
    if  (agar_check_collision(agar_player, agar_circles.get(i))) 
    {
      agar_circles.remove(i);
    } 
  }
  
  
  for (int i = 0; i < agar_circles.size(); i++) 
  {
    agar_circles.get(i).display();
  }
  
}



boolean agar_check_collision(AgarPlayer player, AgarCircle obj) {
  if (agar_player.hits(obj)) 
  {
    float radius = obj.remove();
    obj = null;
    player.grow(radius);
    println("YUUMM!!");
    return true;
  }
  else {
    return false;
  }
}
