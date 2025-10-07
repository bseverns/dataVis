//Activate based on Minim level input
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer in;
BeatDetect beat;

PImage i1;

float inOFF = 0;

void setup() {
  size(800, 800, P3D);

  minim = new Minim(this);//sound
  in = minim.loadFile("groove.mp3", 2048);
  in.play();
  // a beat detection object song SOUND_ENERGY mode with a sensitivity of 10 milliseconds
  beat = new BeatDetect();
  inOFF = 80;

  //images
  i1 = loadImage("screen.png");
}

void draw() {
  //make the background black
  background(0);
  //beat
  beat.detect(in.mix);
  if (beat.isOnset()) { 
    image(i1, mouseX, mouseY, inOFF*random(1,4), inOFF*random(1,4));
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      inOFF = inOFF + 5;
    } else if (keyCode == DOWN) {
      inOFF = inOFF - 5;
    }
  }
}