/* Based on:
 * [015] Intracloud lightning #1
 * 2013 [+++] @tinytintoto
 */
//sound library & analysis reference
import ddf.minim.*;
import ddf.minim.analysis.*;

//audio stuff
Minim minim;
AudioInput input;

//set initial sound level
float inpt = 0;

PImage img;
float nz = 0.0;
final int lines = 100;
final int wave_h = 300;
final float inc = 0.07;



void setup() {
  size( 500, 500, OPENGL );
  frameRate( 30 );
  smooth();
  strokeWeight( 2 );
  background( 0 );
}



void draw() {
  float currentY, lastY = height / 2 + noise( nz ) * wave_h - wave_h / 2;

  //map input level
  inpt = ((input.left.level()*5000)+(input.right.level()*5000));

  img = get();
  image( img, -4, -4, width + 8, height + 8 );
  stroke( inpt );
  //   stroke( random(127) + 128 );
  for ( int i = 0; i < lines; i++ ) {
    currentY = height / 2 + noise( nz ) * wave_h - wave_h / 2;
    line( i * width / lines, lastY, ( i + 1 ) * width / lines, currentY );
    lastY = currentY;
    nz += inc;
  }
}

