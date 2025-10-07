int currentX, currentY;
int lastX, lastY;

float stepRange = 3;

void setup() {
   size(800,600);
    smooth();
    background(0);
    frameRate(60);

    currentX = lastX = width / 2;
    currentY = lastY = height / 2;
}

void draw() {
 background(0);
  //noStroke();
  //fill(0, 190);
  bezier(random(width),random(height), width,height, random(800), random(400), random(600), random(300));

  lastX = currentX;
  lastY = currentY;

  // add a random increment to x and y
  currentX += int(random(-stepRange, stepRange));
  currentY += int(random(-stepRange, stepRange));

  // make sure that the position never leaves the screen
  currentX = constrain(currentX, 0, width);
  currentY = constrain(currentY, 0, height);

  stroke(255);
  line(currentX, currentY, lastX, lastY);
  // draw a line from this
  // position to the last one.
}

