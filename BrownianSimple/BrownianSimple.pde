int currentX, currentY;
int lastX, lastY;

float stepRange = 3;

void setup() {
   size(800,600);
    smooth();
    background(0);

    currentX = lastX = width / 2;
    currentY = lastY = height / 2;
}

void draw() {
  noStroke();
  fill(0, 190);
  rect(0,0, width,height);
  
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
