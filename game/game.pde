int columns = 3;
int rows = 7;

GridBlock[][] playField = new GridBlock[rows][columns];

void setup() {
  size(800, 800);

  drawGrid(columns, rows);
}

void draw() {
  for (int row = 0; row < rows; row++) {
    for (int column = 0; column < columns; column++) {
     
      
      GridBlock gridBlock = playField[row][column];

      if(!gridBlock.isFilled()) continue;

      GridPoint topLeftGridPoint = gridBlock.getTopLeftPoint();
      GridPoint bottomRightGridPoint = gridBlock.getBottomRightPoint();

      int xOfCenterInGridBlock = topLeftGridPoint.getX() + ((bottomRightGridPoint.getX() - topLeftGridPoint.getX())  / 2);
      int yOfCenterInGridBlock = topLeftGridPoint.getY() + ((bottomRightGridPoint.getY() - topLeftGridPoint.getY())  / 2);

      fill(142, 68, 173);
      ellipse(topLeftGridPoint.getX(), topLeftGridPoint.getY() , 2, 2);
      
      fill(255);
      int gridBlockHeight = bottomRightGridPoint.getY() - topLeftGridPoint.getY();
      int circleHeightAndWidth = gridBlockHeight - 20;

      ellipse(xOfCenterInGridBlock, yOfCenterInGridBlock, circleHeightAndWidth, circleHeightAndWidth);
    }
  }
}

void mousePressed() {
  for (int row = 0; row < rows; row++) {
    for (int column = 0; column < columns; column++) {
      GridBlock gridBlock =  playField[row][column];

      boolean isInGridBlock = gridBlock.contains(mouseX, mouseY);

      if (isInGridBlock) {

        gridBlock.setFilled(true);

        println("Matched row: " + gridBlock._row + ", column:" + gridBlock._column);

        int gridBlockRow = gridBlock.getRow();
        int gridBlockColumn = gridBlock.getColumn();

        GridBlock filledBlock = playField[gridBlockRow][gridBlockColumn];

        filledBlock.setFilled(true);

        playField[gridBlockRow][gridBlockColumn] = filledBlock;

        break;
      }
    }
  }
}

void drawGrid(int columns, int rows) {
  int startX = 0;
  int rowHeight = 50;
  int rowWidth = 500;
  int columnWidth = rowWidth / columns;

  for (int row = 0; row < rows; row++) {
    int rowY = row * rowHeight;

    fill(255);

    line(startX, rowY, rowWidth, rowY);

    for (int column = 0; column < columns; column++) {
      int columnBottomRightX = (column + 1)* columnWidth;

      GridPoint topLeftCorner = new GridPoint(column * columnWidth, row * rowHeight);
      GridPoint bottomRightCorner = new GridPoint(columnBottomRightX, rowY + rowHeight);

      GridBlock currentGridBlock = new GridBlock(topLeftCorner, bottomRightCorner, row, column);

      playField[row][column] = currentGridBlock;

      line(columnBottomRightX, rowY, columnBottomRightX, rowHeight);
    }
  }
}

class GridBlock {
  boolean _isFilled = false;
  GridPoint _topLeftPoint;
  GridPoint _bottomRightPoint;

  int _row;
  int _column;

  GridBlock(GridPoint topLeftCorner, GridPoint bottomRightCorner, int row, int column) {
    _topLeftPoint = topLeftCorner;
    _bottomRightPoint = bottomRightCorner;

    _row = row;
    _column = column;
  }

  boolean contains(int x, int y) {
    boolean isInXRange = x >= _topLeftPoint.getX() && x <= _bottomRightPoint.getX();
    boolean isInYRange = y >= _topLeftPoint.getY() && y <= _bottomRightPoint.getY();

    return isInXRange && isInYRange;
  }

  int getRow() {
    return _row;
  }
  int getColumn() {
    return _column;
  }

  void setFilled(boolean isFilled) {
    _isFilled = isFilled;
  }
  
  boolean isFilled(){
     return _isFilled; 
  }

  GridPoint getTopLeftPoint() {
    return _topLeftPoint;
  }
  GridPoint getBottomRightPoint() {
    return _bottomRightPoint;
  }
}

class GridPoint {
  int _x;
  int _y;

  GridPoint(int x, int y) {
    _x = x;
    _y = y;
  }

  int getX() {
    return _x;
  }

  int getY() {
    return _y;
  }
}