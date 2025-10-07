Creature c0 = new Creature(200,300,3);
Creature c1 = new Creature(400,550);
Creature c2 = new Creature(333,555,20);
Creature c3 = new Creature(700,400,3);
Creature c4 = new Creature();

RectangleCreature c5 = new RectangleCreature();

void setup() {
   size(800,600);
    smooth();
    background(0);
    
}

void draw() {
  // clear out background 
  noStroke();
  fill(0, 190);
  rect(0,0, width,height);
  
  // call the draw function from the creature class
  c0.update();
  c0.draw();
  c1.update();
  c1.draw();
  c2.update();
  c2.draw();
  c3.update();
  c3.draw();
  c3.update();
  c4.draw();
  c5.update();
  c5.draw();
   
}
