/*
Box waves

Controls:
  - Move mouse to change its patterns.

Original author:
  aa_debdeb (openprocessing.org/sketch/394519)

Forked by:
  Jason Labbe
*/

int LOOP = 50;
float MAX_BLOCK_WIDTH = 10;
float mult = 3.3;
float heightMult = 3;
color lowColor = color(0, 200, 255);
color highColor = color(150, 220, 255);

ArrayList<Block> blocks;

void setup(){
  size(600, 600, P3D);
  blocks = new ArrayList<Block>();
  float gap = 15;
  int num = 30;
  for(int y = 0; y <= num; y++){
    for(int x = 0; x <= num; x++){
      PVector loc = new PVector(x * gap - num * gap / 2, y * gap - num * gap / 2, 0.0);
      blocks.add(new Block(loc));
    }
  }
}

void mouseMoved() {
  mult = map(mouseX, 0, width, 1, 6);
  heightMult = map(mouseY, 0, height, 5, 0.1);
}

void draw(){
  background(0, 150, 200);
  stroke(0, 100);
  translate(width / 2, height / 2, -100);
  rotateX(HALF_PI / 2);
  rotateZ(HALF_PI / 3);
  for(Block b: blocks){
    b.display();
  }
}

class Block{

  PVector loc;
  int index;
  Block(PVector _loc){
    loc = _loc;
    index = blocks.size();
  }
  
  void display(){
    int loopOffset = int(index*mult);
    pushMatrix();
    float time = (frameCount + loopOffset) % LOOP;
    float bx, by, bz;
    float lx, ly, lz;
    if(time < LOOP / 4.0){
      bx = MAX_BLOCK_WIDTH;
      by = MAX_BLOCK_WIDTH;
      bz = map(time, 0, LOOP / 4.0, MAX_BLOCK_WIDTH, MAX_BLOCK_WIDTH / 5.0);
      lx = 0.0;
      ly = 0.0;
      lz = bz / 2;
    } else if(time < LOOP / 4.0 * 2){
      bx = MAX_BLOCK_WIDTH;
      by = map(time, LOOP / 4.0, LOOP / 4.0 * 2, MAX_BLOCK_WIDTH, MAX_BLOCK_WIDTH / 5.0);
      bz = MAX_BLOCK_WIDTH / 5.0;
      lx = 0.0;
      ly = MAX_BLOCK_WIDTH / 2 - by / 2;
      lz = bz / 2;
    } else if(time < LOOP / 4.0 * 3){
      bx = MAX_BLOCK_WIDTH;
      by = MAX_BLOCK_WIDTH / 5.0;
      bz = map(time, LOOP / 4.0 * 2, LOOP / 4.0 * 3, MAX_BLOCK_WIDTH / 5.0, MAX_BLOCK_WIDTH);
      lx = 0.0;
      ly = MAX_BLOCK_WIDTH / 2 - by / 2;
      lz = bz / 2;
    } else {
      bx = MAX_BLOCK_WIDTH;
      by = map(time, LOOP / 4.0 * 3, LOOP / 4.0 * 4, MAX_BLOCK_WIDTH / 5.0, MAX_BLOCK_WIDTH);
      bz = MAX_BLOCK_WIDTH;
      lx = 0.0;
      ly = MAX_BLOCK_WIDTH / 2 - by / 2;
      lz = bz / 2;    
    }
    float blendValue = map(bz, 2, 10, 0, 1);
    color currentColor = lerpColor(lowColor, highColor, blendValue);
    fill(currentColor);
    
    translate(loc.x + lx, loc.y + ly, loc.z + lz);
    box(bx, by, bz*heightMult);
    popMatrix();
  }
  
}
