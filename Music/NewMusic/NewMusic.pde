
import processing.sound.*;

SoundFile[] songs;
int currentSongIndex = 0; // Initial song index
SoundFile CurrentSong;
boolean isPlaying = false;
boolean isMuted = false;
int buttonWidth = 100;
int buttonHeight = 50;
float xRect, yRect, widthRect, heightRect;
int appWidth, appHeight;
PImage[] songImages;
int numberOfSongs = 3;
int currentSong = numberOfSongs - numberOfSongs;






void setup() {
  size(500, 400);

  // Songs order
  songs = new SoundFile[3];  // Change the size based on the number of songs
  songs[0] = new SoundFile(this, "Super-Mario-Bros.mp3");
  songs[1] = new SoundFile(this, "Green_Greens-4186.mp3");
  songs[2] = new SoundFile(this, "fortnite-og-classic-lobby-music-made-with-Voicemod-technology.mp3");
  xRect = appWidth + 75;
  yRect = appHeight + 30;
  widthRect = 300;
  heightRect = 160;
  
  for (int i = 0; i < 3; i++) {
  songImages[i] = loadImage("../SongImages/Mario.jpg + images.jpg + Fortnite.jpg");
  }
  rect(xRect, yRect, widthRect, heightRect);
  
  
  
  

  // Start playing the first song
  playCurrentSong();
}

void draw() {
  // drawing code goes here
  background(200);
  appWidth = width;
  appHeight = height;



//display play button 
float playButtonX = width / 4 - buttonWidth / 2;
float playButtonY = height / 2 - buttonHeight + 50;
fill(0, 255, 0);//green color
rect(playButtonX, playButtonY, buttonWidth, buttonHeight);
fill(0);
textSize(16);
text("Play", playButtonX + buttonWidth / 2 - 10, playButtonY + buttonHeight / 2 + 5);

// Display stop button below play button
float stopButtonX = width / 4 - buttonWidth / 2;
float stopButtonY = buttonHeight + 215;  // Adjust the vertical position
fill(0, 0, 255);  // Blue color
rect(stopButtonX, stopButtonY, buttonWidth, buttonHeight);
fill(0);
text("Stop", stopButtonX + buttonWidth / 2 - 12, stopButtonY + buttonHeight / 2 + 5);

// Display pause button 
float pauseButtonX = width / 2 - buttonWidth / 2;
float pauseButtonY = height / 2 - buttonHeight + 50;
fill(255, 0, 0);  // Red color
rect(pauseButtonX, pauseButtonY, buttonWidth, buttonHeight);
fill(0);
text("Pause", pauseButtonX + buttonWidth / 2 - 15, pauseButtonY + buttonHeight / 2 + 5);

//Display Restart button 
float restartButtonX = width / 2 - buttonWidth / 2;
float restartButtonY =  buttonHeight + 215;
fill(255, 255, 0);  // Yellow color
rect(restartButtonX, restartButtonY, buttonWidth, buttonHeight);
fill(0);
text("Restart", restartButtonX + buttonWidth / 2 - 20, restartButtonY + buttonHeight / 2 + 5);

// Display mute button 
float muteButtonX = 3 * width / 4 - buttonWidth / 2;
float muteButtonY =  buttonHeight + 280;
fill(150, 0, 150);  // Purple color
rect(muteButtonX, muteButtonY, buttonWidth, buttonHeight);
fill(0);
text("Mute", muteButtonX + buttonWidth / 2 - 15, muteButtonY + buttonHeight / 2 + 5);

// Display next button 
float nextButtonX = width / 2 - buttonWidth + 50;
float nextButtonY = buttonHeight + 280;
fill(255, 165, 0);  // Orange color
rect(nextButtonX, nextButtonY, buttonWidth, buttonHeight);
fill(0);
text("Next", nextButtonX + buttonWidth / 2 - 15, nextButtonY + buttonHeight / 2 + 5);

// Display previous button
float previousButtonX = width / 4 - buttonWidth / 2;
float previousButtonY = buttonHeight + 280;
fill(255, 69, 0);  // Red-Orange color
rect(previousButtonX, previousButtonY, buttonWidth, buttonHeight);
fill(0);
text("Previous", previousButtonX + buttonWidth / 2 - 20, previousButtonY + buttonHeight / 2 + 5);
}


void keyPressed() {
  // Check for key presses to switch songs
  if (keyCode == UP) {
    // Increment the song index
    currentSongIndex = (currentSongIndex + 1) % songs.length;
    playCurrentSong();
  } else if (keyCode == DOWN) {
    // Decrement the song index
    currentSongIndex = (currentSongIndex - 1 + songs.length) % songs.length;
    playCurrentSong();
  }
}

void mousePressed() {
  // Check if the mouse is over the play button
  float playButtonX = width / 4 - buttonWidth / 2;
  float playButtonY = height / 2 - buttonHeight + 5;
  if (mouseX > playButtonX && mouseX < playButtonX + buttonWidth && mouseY > playButtonY && mouseY < playButtonY + buttonHeight) {
    togglePlayPause();
  }

  // Check if the mouse is over the stop button
  float stopButtonX = width / 4 - buttonWidth + 50;
  float stopButtonY = buttonHeight + 215;
  if (mouseX > stopButtonX && mouseX < stopButtonX + buttonWidth && mouseY > stopButtonY && mouseY < stopButtonY + buttonHeight) {
    stopCurrentSong();
  }

  // Check if the mouse is over the pause button
  float pauseButtonX = width / 2 - buttonWidth / 2;
  float pauseButtonY = height / 2 - buttonHeight / 2;
  if (mouseX > pauseButtonX && mouseX < pauseButtonX + buttonWidth && mouseY > pauseButtonY && mouseY < pauseButtonY + buttonHeight) {
    togglePlayPause();
  }
  //Check if the mouse is over the restart button
  float restartButtonX = width / 2 - buttonWidth / 2;
  float restartButtonY = buttonHeight + 215;
  if (mouseX > restartButtonX && mouseX < restartButtonX + buttonWidth && mouseY > restartButtonY && mouseY < restartButtonY + buttonHeight) {
    restartCurrentSong();
  }

  //Check if the mouse is over the mute button
  float muteButtonX = 3 * width / 4 - buttonWidth / 2;
  float muteButtonY =  buttonHeight + 280;
  if (mouseX > muteButtonX && mouseX < muteButtonX + buttonWidth && mouseY > muteButtonY && mouseY < muteButtonY + buttonHeight) {
    toggleMute();
  }

  //Check if the mouse is over the next button
  float nextButtonX = width / 2 - buttonWidth + 50;
  float nextButtonY = buttonHeight + 280;
  if (mouseX > nextButtonX && mouseX < nextButtonX + buttonWidth && mouseY > nextButtonY && mouseY < nextButtonY + buttonHeight) {
    nextSong();
  }

  //Check if the mouse is over the previous button
  float previousButtonX = width / 4 - buttonWidth / 2;
  float previousButtonY = buttonHeight + 280;
  if (mouseX > previousButtonX && mouseX < previousButtonX + buttonWidth && mouseY > previousButtonY && mouseY < previousButtonY + buttonHeight) {
    previousSong();
  }
}



void playCurrentSong() {
  // Stop any currently playing song
  for (SoundFile song : songs) {
    if (song.isPlaying()) {
      song.stop();
    }
  }

  // Play the selected song
  songs[currentSongIndex].play();
}

void togglePlayPause() {
  isPlaying = !isPlaying;
  
  if (isPlaying) {
    // If currently playing, stop it before starting again
    if (songs[currentSongIndex] != null && songs[currentSongIndex].isPlaying()) {
      songs[currentSongIndex].stop();
    }
    songs[currentSongIndex].play();
  } else {
    if (songs[currentSongIndex] != null) {
      songs[currentSongIndex].pause();
    }
  }
}



void stopCurrentSong() {
  // Stop the currently playing song
  for (SoundFile song : songs) {
    if (song != null && song.isPlaying()) {
      song.stop(); }
  }
}
    
  

void restartCurrentSong() {
  if (songs[currentSongIndex] != null && isPlaying) {
    songs[currentSongIndex].stop();
    songs[currentSongIndex].play();
  }
}

void toggleMute() {
  isMuted = !isMuted;

  // Mute or unmute the current song
  if (songs[currentSongIndex] != null) {
    songs[currentSongIndex].amp(isMuted ? 0 : 1);  // Set numbers to 0 for mute, 1 for unmute
  }
}

void nextSong() {
  println("Before nextSong - currentSongIndex: " + currentSongIndex);
  currentSongIndex = (currentSongIndex + 1) % songs.length;
  println("After nextSong - currentSongIndex: " + currentSongIndex);
  playCurrentSong();
}

void previousSong() {
  currentSongIndex = (currentSongIndex - 1 + songs.length) % songs.length;
  playCurrentSong();
}
