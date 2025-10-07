class Cell {
  float x, y;
  float state;      
  float nextState;  
  float lastState = 0; 
  Cell[] neighbours;

  Cell(float ex, float why) {
    x = ex * _cellSize;
    y = why * _cellSize;
    nextState = ((x/500) + (y/300)) * 14;  
    state = nextState;
    neighbours = new Cell[0];
  }

  void addNeighbour(Cell cell) {
    neighbours = (Cell[])append(neighbours, cell);
  }



  /////////////////////////////////....NEXT STATE..../////////////////////////////////
  void calcNextState() {

    float total = 0;        
    for (int i=0; i < neighbours.length; i++) {  
      total += neighbours[i].state;
    } 
    
    //float average = int(mappedInput);
    
    //divide by bigger numbers for
    float average = int(total/31);

    if (average == 300) {
      nextState = 0;
    } else if (average == 0) {
      nextState = 300;
    } else {
      nextState = state + average;
      if (lastState > 0) { 
        nextState -= lastState;
      }   
      if (nextState > 300) { 
        nextState = 300;
      } else if (nextState < 0) { 
        nextState = 0;
      }
    }

    lastState = state;
  }

  void drawMe() {
    state = nextState;
    stroke(0);
    fill(200 + state/5, 100, 100);
    rect(x, y, _cellSize-2, _cellSize-2);
  }
}