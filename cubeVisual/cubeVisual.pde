//rotation starting values
float x=0.1;
float y=0.1;
float z=0.1;
//rotation directions and speeds
float dx=random(-0.05,0.05);
float dy=random(-0.05,0.05);
float dz=random(-0.05,0.05);
//initial size of cube
float s=200;

void setup()
{
//size+3D enabled
size(600,600,P3D);
//smooths shapes more than normal
smooth(8);
//draws initial background so that there isn't a grey frame on slow computers
background(0);
}

void keyPressed(){
//ENTER restarts rotation if stopped, resets rotation speed values
  if(keyCode==ENTER){
    dx=random(-0.05,0.05);
    dy=random(-0.05,0.05);
    dz=random(-0.05,0.05);
  }
  
//SPACE stops rotation, sets rotation speed values to 0
  if(key==' '){
    dx=0;
    dy=0;
    dz=0;
}
//SHIFT sets cube size to full size, 200
  if(keyCode==SHIFT){
    s=200;
}
}

void mousePressed(){
//LEFT CLICK sets cube size to half size, 100 (normal size being 200
  if(mousePressed){
    s=100;
  }
}

void draw()
{
background(0);
fill(255);
text("SPACE=STOP CUBE",470,30);
text("ENTER=START CUBE",470,50);
text("CLICK=SMALLEN CUBE",470,70);
text("SHIFT=ENLARGE CUBE",470,90);
//moves shapes to enter of screen
translate((width/2),(height/2),0);

//defines rotations of cubes
rotateX(x);
rotateY(y);
rotateZ(z);

//defines aesthetic for large cube
strokeWeight(6);
stroke(random(0,255),random(0,255),random(0,255));
noFill();

//draws boxes
box(s);
box(s-50);
box(s-100);
box(s-150);

//draws interior sphere
sphere(10);

//allows for rotation
x=x+dx;
y=y+dy;
z=z+dz;

//defines aesthetics for small white cubes
stroke(#FFFFFF);
strokeWeight(2);
noFill();
//TRANSLATE moves the white cubes in relation to the first translation so that they are 
translate((width/2)-500,0,0);
box(10);
translate((width/2)+100,0,0);
box(10);
translate(width/2-500,200,0);
box(10);
translate(0,-400,0);
box(10);
translate(0,200,200);
box(10);
translate(0,0,-400);
box(10);

stroke(random(0,255),random(0,255),random(0,255));
noFill();
}