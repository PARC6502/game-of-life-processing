class Cell {
  //static int cellWidth;
  int x, y;
  boolean on = false;
  boolean nextOn = false; 
  Cell(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  void calculateNextState() {
    int liveNeighbours = this.countNeighbours();
    
    if (this.on && (liveNeighbours < 2 || liveNeighbours > 3) ) this.nextOn = false;
    else if (!this.on && liveNeighbours == 3) this.nextOn = true;
    else this.nextOn = this.on;
    
  }
  
  int countNeighbours() {
    int liveNeighbours = 0;
    for (int i=-1;i<2;i++) {
      for (int j=-1; j<2;j++) {
        int row = (x+i+numX) % numX;
        int col = (y+j+numY) % numY;
        if (!(row == x && col==y) && cells[row][col].on) liveNeighbours++;
      }
    }
   
    return liveNeighbours;
  }
  
  void updateState() {
    this.on = this.nextOn;
  }
  
  void draw() {
    color fillcol = this.on ? color(0) : color(255);
    fill(fillcol);
    float weight = cellWidth/30;
    strokeWeight(weight);
    rect(x*cellWidth,y*cellWidth,cellWidth-weight*2, cellWidth-weight*2); 
  }
  
  
}
