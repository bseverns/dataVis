

void setup() {
  size(1000, 600);
}

void draw() {

   background(10, 200, 10);

      if(mouseY < height/4) { //first quarter
        fill(255);
    background(150, 100, 0);
      for (float i = 0; i < 2; i += 0.01) {
    float rectX = mouseX;
    float rectY = mouseY;
    //rotate(frameCount * 0.0001);
    stroke(0, 100);
    rect(rectX, rectY, width/ i, height/i);
      }
  }

  for (float i = 0; i < 2; i += 0.01) { //second quarter
    float rectX = mouseX;
    float rectY = mouseY;
    //rotate(frameCount * 0.0001);
    stroke(0, 100);
    line(rectX, rectY, width/2 * i, height/2);
    
  }
  
      if(mouseY > height/2 && mouseY < height - height/4) { //third quarter
    background(10, 10, 100);
      for (float i = 0; i < 2; i += 0.01) {
    float rectX = mouseX;
    float rectY = mouseY;
    stroke(255, 100);
    line(rectX, rectY * sin(rectX/i), width/2 * i, height/2);
      }
  }   
  
  
      if(mouseY > height - height/4) { //fourth quarter
    background(200, 10, 10);
      for (float i = 0; i < 2; i += 0.01) {
        fill(100,0,0);
    ellipse(mouseX, mouseY * sin(i) * 100, frameCount/i, frameCount/i);
      }
  }   
  
}
