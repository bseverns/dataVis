import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
 
Minim minim;
AudioPlayer player;
AudioInput input;
PFont font;
AudioMetaData meta;
int metaX=715;
int metaY=595;
int sW=0;
 
void setup() {
  size(1000, 700);
 
  minim = new Minim(this);
  player = minim.loadFile("01 La Femme d'Argent.mp3", 1024);
  meta = player.getMetaData();
  player.play();
  font=loadFont("Damascus-18.vlw");
  textFont(font, 18);
  smooth();
}
 
 
void draw() {
  background(0);
/*  if (keyPressed==true) {
    stop();
  }*/
  fill(255);
  text("Title: " + meta.title(), metaX, metaY);
  text("Author: " + meta.author(), metaX, metaY+20);
  text("Album: " + meta.album(), metaX, metaY+40);
  text("Date: " + meta.date(), metaX, metaY+60);
  text("Track: " + meta.track(), metaX, metaY+80);
  text("Disc: " + meta.disc(), metaX, metaY+100);
  stroke(255);
  strokeWeight(2);
 
  // we draw the waveform by connecting neighbor values with a line
  // we multiply each of the values by 50
  // because the values in the buffers are normalized
  // this means that they have values between -1 and 1.
  // If we don’t scale them up our waveform
  // will look more or less like a straight line.
  for (int i = 0; i < player.bufferSize() - 1; i++) {
    stroke(91,217,245);
    line(i, 330 + player.left.get(i)*50, i+1, 330 + player.left.get(i+1)*50);
    stroke(239,134,156);
    line(i, 325 + player.left.get(i)*50, i+1, 325 + player.left.get(i+1)*50);
    stroke(65,172,196);
    line(i, 470 + player.right.get(i)*50, i+1, 470 + player.right.get(i+1)*50);
    stroke(239,134,156);
    line(i, 475 + player.right.get(i)*50, i+1, 475 + player.right.get(i+1)*50);
  }
}
 
void stop() {
  // the AudioPlayer you got from Minim.loadFile()
  player.close();
  // the AudioInput you got from Minim.getLineIn()
  minim.stop();
 
  // this calls the stop method that
  // you are overriding by defining your own
  // it must be called so that your application
  // can do all the cleanup it would normally do
  super.stop();
}
