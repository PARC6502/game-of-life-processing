int cellWidth = 2;
int numX;
int numY;
Cell[][] cells;

void setup() {
  size(700, 700);
  frameRate(10);
  numX = floor(width/cellWidth);
  numY = floor(height/cellWidth);
  cells = new Cell[numX][numY];
  restart();
}

void restart() {
  frameCount = 0;
  for (int x =0; x<numX; x++) {
    for (int y=0; y<numY; y++) {
      cells[x][y] = new Cell(x, y);
      
      /* Uncomment the seed you want to use */
      //concentricSeed1(cells, x, y);
      //concentricSeed2(cells, x, y);
      crossSeed(cells, x, y);
      //randomlySeed(cells, x, y);
      //cells[x][y].draw();
    }
  }
}

boolean record = true;
int frameCounter = 0;
int totalRecordedFrames = 210;

float zoom = 3.4;
float zoomDecrementor = 0.04;
float zoomEnd = 1.04;
int zoomStartFrame = 30;
int zoomEndFrame = (int) ((zoom-zoomEnd)/zoomDecrementor)+1;
void draw() {
  /* Zoom stuff */
  if (frameCount > zoomStartFrame && zoom>zoomEnd) {
    zoom -= zoomDecrementor;
    println(frameCount);
  }
  
  /* Calculate all the next states before updating state/drawing */
  for (int x =0; x<numX; x++) {
    for (int y=0; y<numY; y++) {
      cells[x][y].calculateNextState();
    }
  }
  push();
  /* More zoom stuff */
  if (frameCount < zoomEndFrame) {
    translate(-numX*(zoom-1), -numY*(zoom-1));
    scale(zoom);
  }
  
  /* Update state and draw */
  for (int x =0; x<numX; x++) {
    for (int y=0; y<numY; y++) {
      cells[x][y].updateState();
      cells[x][y].draw();
    }
  }
  pop();
  
  /* Record stuff */
  if (record) {
    saveFrame("crossZoom2/"+nf(frameCounter, 3)+".png");
    if (frameCounter == totalRecordedFrames-1) {
      exit();
    }
  }
  frameCounter++;
}

void mousePressed() {
  restart();
}

void concentricSeed1(Cell[][] cells, int x, int y) {
  int absPoint = 40;
  for (int i = 0; i<4; i++) {
    float thisPoint = pow(y-numY/2, 2)+pow(x-numX/2, 2) - pow(numX/(i+3), 2);
    if (abs(thisPoint)<absPoint) {
      cells[x][y].on = true;
      break;
    }
  }
}

void concentricSeed2(Cell[][] cells, int x, int y) {
  int absPoint = 40;
  float circlePoint1 = pow(y-numY/2, 2)+pow(x-numX/2, 2) - pow(numX/2-2, 2);
  float circlePoint2 = pow(y-numY/2, 2)+pow(x-numX/2, 2) - pow(numX/4, 2);
  float circlePoint3 = pow(y-numY/2, 2)+pow(x-numX/2, 2) - pow(numX/6, 2);
  float circlePoint4 = pow(y-numY/2, 2)+pow(x-numX/2, 2) - pow(numX/8, 2);
  if (abs(circlePoint1)<absPoint || abs(circlePoint2)<absPoint || abs(circlePoint3)<absPoint || abs(circlePoint4)<absPoint) cells[x][y].on = true;
}

void crossSeed(Cell[][] cells, int x, int y) {
  if (x==floor(numX/2)) cells[x][y].on = true;
  if (y==floor(numY/2)) cells[x][y].on = true;
}

void randomlySeed(Cell[][] cells, int x, int y) {
  cells[x][y].on = random(1)>0.5;
}
