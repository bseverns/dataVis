

int x = 5;
/*
for (int i = 15; i >=0; i -=1) {
  line(x, 20, x, 80);
  x +=5;
}
*/

void setup () {
  drawLines(x, 30);
}

void drawLines(int x, int num) {
  line(x, 20, x, 80);
  if (num > 0) {
    drawLines(x+5, num-1);
  }
}
