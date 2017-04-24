int columns = 3;
int rows = 7;

int gridBlockIndex = 0;

GridBlockCollection gridBlocks = new GridBlockCollection(rows * columns);

void setup(){
    size(800, 800);
    
    drawGrid(columns, rows);
}

void draw(){}

void mousePressed(){
    for(int i = 0; i < gridBlocks.length(); i++){
       
        GridBlock gridBlock = gridBlocks.get(i);
        // check if item is in block
        
        if(gridBlock != null){
            boolean isInGridBlock = gridBlock.contains(mouseX, mouseY);
            
            if(isInGridBlock){
                gridBlock.setFilled(true);
                
                println("Clicked row: " + gridBlock._row + ", column:" + gridBlock._column);
            }
        }
        
    }
}


void drawGrid(int columns, int rows){
    int startX = 0;
    int startY = 0;
    int rowHeight = 50;
    int rowWidth = 500;
    int columnWidth = rowWidth / columns;
    
    for(int row = 0; row < rows; row++){
       // for each row create column
       
       int rowY = row * rowHeight;
       
       fill(255);
       
       line(startX, rowY, rowWidth, rowY);
       
       // loop though column
       
       for(int column = 1; column <= columns; column++){
          int columnX = column * columnWidth;
          
          GridBlock currentGridBlock = new GridBlock((column - 1) * columnWidth, rowY, columnX, rowY + rowHeight, row, column);
          
          // add item to array
          gridBlocks.add(currentGridBlock);
          gridBlockIndex += 1;
          
          // check if array is gridblock with grow and column
          
          line(columnX, rowY, columnX, rowHeight);
       }
     
    }
}

class GridBlock{
    boolean _isFilled = false;
    int _x1;
    int _y1;
    int _x2;
    int _y2;
    
    int _row;
    int _column;
    
    GridBlock(int x1, int y1, int x2, int y2, int row, int column){
      _x1 = x1;
      _y1 = y1;
      
      _x2 = x2;
      _y2 = y2;
      
      _row = row;
      _column = column;
    }
    
    boolean contains(int x, int y){
       boolean isInXRange = x >= _x1 && x <= _x2;
       boolean isInYRange = y >= _y1 && y <= _y2;
       
       return isInXRange && isInYRange;
    }
    
    void setFilled(boolean isFilled){
      _isFilled = isFilled;
    }
}


class GridBlockCollection{
  GridBlock[] _gridBlocks;
  int _gridBlockIndex = 0;
  
  GridBlockCollection(int collectionLength){
    _gridBlocks = new GridBlock[collectionLength];
  }
  
  void add(GridBlock gridBlock){
     _gridBlocks[_gridBlockIndex] = gridBlock;
     _gridBlockIndex += 1;
  }
  
  int length(){
     return _gridBlocks.length;
  }
  
  GridBlock get(int index){
    return _gridBlocks[index];
  }
}