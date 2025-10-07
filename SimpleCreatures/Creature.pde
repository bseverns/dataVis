class Creature {
  int currentX, currentY;
  int lastX, lastY;
  
  // creature width
  // creature height
  // number of eyes, 
  // color of feet,
  // 


  float stepRange = 3;

  public Creature() {
     this(0,0);
  }

  public Creature(int x, int y) {
     this(x,y,3);
  }

  // a class / object construtor, 
  // this gets automatically called when 
  // a new class is created.
  public Creature(int x, int y, float stepRange) {
    currentX = lastX = x;
    currentY = lastY = y;
    
    this.stepRange = stepRange;
    
  }

  public void update() {
    lastX = currentX;
    lastY = currentY;

    // add a random increment to x and y
    currentX += int(random(-stepRange, stepRange));
    currentY += int(random(-stepRange, stepRange));

    // make sure that the position never leaves the screen
    currentX = constrain(currentX, 0, width);
    currentY = constrain(currentY, 0, height);

    
  }


  // class drawing function
  public void draw() {
    stroke(255);
//    line(currentX, currentY, lastX, lastY); 
    ellipse(currentX, currentY, 10,10);
    
    // draw a line from this 
    // position to the last one.
  }
}

