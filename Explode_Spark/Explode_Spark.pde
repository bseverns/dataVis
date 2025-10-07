/**
 * Explode 
 * by Daniel Shiffman. 
 * 
 * Mouse horizontal location controls breaking apart of image and 
 * Maps pixels from a 2D image into 3D space. Pixel brightness controls 
 * translation along z axis. 
 */

PImage img;       // The source image
int cellsize = 3; // Dimensions of each cell in the grid
int columns, rows, xW;   // Number of columns and rows in our system

void setup() {
  //fullScreen(P3D);
  size(640, 360, P3D); 
  img = loadImage("one.jpg");  // Load the image
  columns = img.width / cellsize;  // Calculate # of columns
  rows = img.height / cellsize;  // Calculate # of rows
}

void draw() {
  background(255);
  // Begin loop for columns
  for ( int i = 0; i < columns; i++) {
    // Begin loop for rows
    for ( int j = 0; j < rows; j++) {
      int x = i*cellsize + cellsize/2;  // x position
      int y = j*cellsize + cellsize/2;  // y position
      int loc = x + y*img.width;  // Pixel array location
      color c = img.pixels[loc];  // Grab the color

      for (int xW = 0; x < img.width; xW++) {
        // Calculate a z position based on time and pixel brightness!!!  //
      }
      float z = ( mouseX * 1.2 / float(width)) * brightness(img.pixels[loc]) - 20.0;
      // Translate to the location, set fill and stroke, and draw the rect
      pushMatrix();
      translate(x, y, z);
      fill(c, 204);
      noStroke();
      rectMode(CENTER);
      rect(0, 0, cellsize, cellsize);
      popMatrix();
    }
  }
}