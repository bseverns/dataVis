int x = 250;
int y = 500;
int a = 75;
int n = 15;

void setup() {
  size(500, 500);
  noLoop();
}

void draw() {
  stroke(0);
  strokeWeight(1);
  drawT(x, y, a, n);
}

void drawT(int xpos, int ypos, int apex, int num) {
  rect (xpos*1.25, ypos*1.25, xpos, ypos-apex);
  rect (xpos - apex*1.25, ypos - apex*1.25, xpos + apex, ypos - apex);
  
  if (num > 0) {
    drawT(xpos- apex, ypos - apex, apex / 2, num - 1);
    drawT(xpos + apex, ypos - apex, apex/2, num - 1);
  }
}
