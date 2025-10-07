int startSECOND, startMINUTE, startTOTAL;
int stopSECOND, stopMINUTE, stopTOTAL;
int dis_m,dis_s;
boolean startcount=false;
PFont font;

void setup()
{
  font=loadFont("AgencyFB-Reg-48.vlw");
  textFont(font, 50);
  size(300,150);smooth();
}

void draw()
{
  drawbuttons();
   
  if(mousePressed && rectSTART())
  {
    startSECOND=second();
    startMINUTE=minute();
    startTOTAL = startMINUTE*60 + startSECOND;
    startcount=true;
  }
  
  
  if(mousePressed && rectPAUSE())
  {
    if(startcount==true) startcount=false; else startcount=true;
  }
  
  
  if(mousePressed && rectSTOP())
  {
    startcount=false;
  }
 
    calculate();
    display();
  }

void drawbuttons()
{
  background(0);
  
  fill(#00FF28); rect(0,0,100,30); 
  fill(#FF8000); rect(120,0,100,30);
  fill(#FF0D00); rect(240,0,50,30);
    
  fill(0); textFont(font, 20);
  text("START/RESET",10,25);
  text("PAUSE/RESUME",122,25);
  text("STOP",250,25);
  
}


boolean rectSTART()
{
  if(mouseX>=0&&mouseX<=100&&mouseY>=0&&mouseY<=30) return true;
  else return false;
}

boolean rectPAUSE()
{
  if(mouseX>=120&&mouseX<=220&&mouseY>=0&&mouseY<=30)  {return true;}
  else return false;
}

boolean rectSTOP()
{
 if(mouseX>=240&&mouseX<=290&&mouseY>=0&&mouseY<=30)  {return true;}
  else return false;
  
}

void calculate()
{
  if(startcount)
    {
      stopMINUTE = minute();
      stopSECOND = second();
     
      stopTOTAL = stopMINUTE*60 + stopSECOND;
  
      int diff = stopTOTAL-startTOTAL;
      dis_m = diff/60;
      dis_s = diff - dis_m*60;
    }
}

void display()
{
  fill(#FFEA00);
  textFont(font,60);
  text(nf(dis_m,2)+":"+nf(dis_s,2), 80, 100);
}
