float x = mouseX;
float y = mouseY;

void setup() {
  size (500, 500);
  background(0);
  frameRate(4);
}

void draw() {
  background(0);
  stroke(0);
  fill(255, 0, 0);
  rect(mouseX, mouseY, 100, 100);
}

void mousePressed(){
  if(mouseX < 150) {
    background(255);
  }
  else if (mouseX < 300) {
    background(255, 255, 0);
  }
  else if (mouseX > 300) {
    background (random(0, 255), random(0, 255), random(0, 255));
  }
}
