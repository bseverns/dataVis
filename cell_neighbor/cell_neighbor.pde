//Cell fill with selections from a video?
//super-processed?

Cell[][] _cellArray;     // two dimensional array of cells
int _cellSize = 10;      // size of each cell
int _numX, _numY;        // dimensions of grid

////////////////////////////////////////////////////

void setup() {
  fullScreen();
  //size(600, 600);
  _numX = floor(width/_cellSize);
  _numY = floor(height/_cellSize);
  restart();
  colorMode(HSB, 360, 100, 100);
  rectMode(CENTER);
  frameRate(25);
} 

////////////////////////////////////////////////////

void restart() {
  _cellArray = new Cell[_numX][_numY];  
  for (int x = 0; x<_numX; x++) {
    for (int y = 0; y<_numY; y++) {  
      Cell newCell = new Cell(x, y);  
      _cellArray[x][y] = newCell;
    }
  }          


  for (int x = 0; x < _numX; x++) {
    for (int y = 0; y < _numY; y++) {  

      int above = y-1;    
      int below = y+1;    
      int left = x-1;      
      int right = x+1;      

      if (above < 0) { 
        above = _numY-1;
      }  
      if (below == _numY) { 
        below = 0;
      }  
      if (left < 0) { 
        left = _numX-1;
      }  
      if (right == _numX) { 
        right = 0;
      }  

      _cellArray[x][y].addNeighbour(_cellArray[left][above]);  
      _cellArray[x][y].addNeighbour(_cellArray[left][y]);    
      _cellArray[x][y].addNeighbour(_cellArray[left][below]);  
      _cellArray[x][y].addNeighbour(_cellArray[x][below]);  
      _cellArray[x][y].addNeighbour(_cellArray[right][below]);  
      _cellArray[x][y].addNeighbour(_cellArray[right][y]);  
      _cellArray[x][y].addNeighbour(_cellArray[right][above]);  
      _cellArray[x][y].addNeighbour(_cellArray[x][above]);
    }
  }
}

////////////////////////////////////////////////////

void draw() {
  background(0, 100, 100);

  for (int x = 0; x < _numX; x++) {
    for (int y = 0; y < _numY; y++) {
      _cellArray[x][y].calcNextState();
    }
  }

  translate(_cellSize/2, _cellSize/2);    

  for (int x = 0; x < _numX; x++) {
    for (int y = 0; y < _numY; y++) {
      _cellArray[x][y].drawMe();
    }
  }
}

////////////////////////////////////////////////////

void mousePressed() {
  if (frameCount <= 1000) {
    saveFrame("neighbor-####.png");
  }  
  restart();
}

////////////////////////////////////////////////////