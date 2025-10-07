people[] personnages;

void setup(){
  size(640,640);
  noStroke();stroke(255,128);
  float pas = 20;
  smooth();
  personnages = new people[0];
  for(float a=0;a<(width/pas-1);a++){
  for(float b=0;b<(height/pas-1);b++){
    if(random(3)>1){
    new people(a*pas+pas*0.5, b*pas+pas*0.5, pas*0.8);
    }
  }
     
  }
  fill(0,20);
    background(0);
}
 
void draw(){
 //background(0);
 rect(0,0,width,height);
  for(int a=0;a<personnages.length;a++){
    personnages[a].dessine();
     
  }
}

class people{
  color c;
  float x,y,taille,vx,vy,vitesse;
  people(float _x, float _y, float maxi){
    float an=random(TWO_PI);
    c = color(random(100, 255),random(100, 255),random(50));
    x = _x; y=_y;taille=random(2,maxi);
    vitesse = ((maxi-taille)/3)+0.5;
    vx = cos(an)*vitesse; vy = sin(an)*vitesse;
    personnages = (people[]) append (personnages, this);
  }
  void dessine(){
  //  fill(c);
    x+=vx;y+=vy;vy+=0.1;
    if(x<taille/2){x=taille/2;vx=-vx;}
    if(y<taille/2){y=taille/2;vy=-vy;}
    if(x>width-taille/2){x=width-taille/2;vx=-vx;}
    if(y>height-taille/2){y=height-taille/2;vy=-vy*0.75;}
    for(int a=0;a<personnages.length;a++){
      people deux = personnages[a];
      if(deux!=this){
        float d=dist(deux.x, deux.y, x , y);
        if(d<((taille+deux.taille)/2)){
          float ang = atan2(y-deux.y, x-deux.x);
          vx = cos(ang)*vitesse;vy=sin(ang)*vitesse;
        } else {
          if(d<30){
            //stroke(255);
            line(x,y,deux.x, deux.y);
             
          }
         
        }
         
      }
    } 
  } 
}
