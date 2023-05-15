
SoundFile music;
SoundFile hit_sfx; 
SoundFile heal_sfx; 
SoundFile scramble_sfx; 
SoundFile game_over_sfx; 

SoundFile music_player; 

String music_path = "music.mp3"; 
String hit_path = "hitSfx.mp3"; 
String heal_path = "heal.wav"; 
String scramble_path = "scramble.wav";
String game_over_sfx_path = "gameOver.mp3"; 

float music_vol = 0.1;
float sfx_vol = 0.15;

boolean music_playing = false; 

SoundFile playSound(SoundFile file, String path, float vol) {
  
  file = new SoundFile(this, path);
  file.play(1, vol);
  return file;
  
}

void stopSound(SoundFile sound) {
  if (sound != null) {
    sound.stop();
  }
  else {
    println("Sound is null");
  }

}

void loopSound(SoundFile sound) {
  sound.loop();
}
