roue[] roues;
int numb=12, numpoints=int(random(5,25));
float ray=random(100,200);
float distancemin=random(40,80);
boolean hasard=true;

void setup() {
  size(640, 640);
  if(floor(random(2))==0){;
  stroke(255,20);  
  background(0);
  } else {
  stroke(0,20);  
  background(255);
    
  }
  roues = new roue[0];
  float wn=width/numb, hn=height/numb;
  for (int a=0; a<numb; a++) {
    for (int b=0; b<numb; b++) {
      new roue(a*wn+wn/2, b*hn+hn/2);
    }
  }
}

void draw(){
 for(int a=0;a<roues.length;a++){
   roues[a].dessine();
 }
 noLoop();
 save("img"+numb+""+millis()+".png");
}

class roue {
  float x, y;
  PVector[] points;
  roue(float _x, float _y) {
    x=_x; y=_y;  
    points = new PVector[numpoints];
    float an=TWO_PI/numpoints;
    float modif=0;
     if(hasard){ modif=random(an);}
    for(int a=0;a<numpoints;a++){
      points[a]=new PVector(x+cos(an*a+modif)*ray, y+sin(an*a+modif)*ray);
    }
    roues = (roue[]) append(roues, this);
  }
  void dessine() {
     for(int a=0;a<points.length;a++){
       PVector poin=points[a];  
       for(int r=0;r<roues.length;r++){
         roue rr=roues[r];
         if(rr!=this){
           for(int p=0;p<rr.points.length;p++){
             PVector v=rr.points[p];
             float d=dist(v.x,v.y,poin.x,poin.y);
             if(d<distancemin){
               line(v.x,v.y,poin.x,poin.y);
             }
           } 
         }
       }
     }
  }
}
