int amtCells = 100; //Amount of cells we want
cell cells [][] = new cell[amtCells][amtCells]; //Set up a 2D array for cells
void setup(){
  size(500,500); //Make a box
  frameRate(30); //Set framerate
  for(int i = 0; i < amtCells; i++){
    for(int j = 0; j < amtCells; j++){
      cells[i][j] = new cell(i, j);
    }
  }
}

void draw(){
  background(255);
  
  for(int i = 0; i < amtCells; i++){//Find all the neighbours
    for(int j = 0; j < amtCells; j++){
      cells[i][j].liveNig = cells[i][j].liveNghbour(i,j);
    }
  }
  
  for(int i = 0; i < amtCells; i++){//Calculate and display
    for(int j = 0; j < amtCells; j++){
      cells[i][j].calculate();
      cells[i][j].display();
    }
  }
}

class cell{//Create a class for the cells
  float h,w,x,y; //Sets up: Height, Width, X and Y coordinates
  boolean dead; //Whether the cell is dead or not
  int liveNig; //Live neighbours
  cell(int i, int j){//Initialise
    h = 50; //Set height
    w = 50; //Set width
    x = map(j, 0, amtCells, 0, width); //Map X to the column value
    y = map(i, 0, amtCells, 0, height); //Map Y to the row value
    float AorD = random(amtCells * 4);
    
    if( AorD < amtCells){
      dead = false;
    }else{
      dead = true;
    }
  }
  
  void display(){//Displays the cell
    if(dead == true){  
      fill(20); //Sets the colour
    }else{
      fill(200);
    }
    rect(x,y,h,w); //Draws the rectangle
  }
  
  void calculate(){ //Calculates each generation
    if(dead == false){//alive
      if(liveNig < 2){//Underpop
        dead = true;
      }else if(liveNig == 2 || liveNig == 3){//Lives
        dead = false;
      }else if(liveNig > 3){//Overpop
        dead = true;
      }
    }else{//dead
      if(liveNig == 3){//reproduce
        dead = false;
      }
    }
  }
  
  int liveNghbour(int i, int j){
    int alive = 0;//Amount of live
    int directions[][] = {{-1, -1}, {-1, 0}, {-1, +1},
                          {0, -1},           {0, +1},
                          {+1, -1}, {+1, 0}, {+1, +1}};//Set all the directions
                          
    for(int dir[] : directions){//For each direction
      try{
        if(cells[i+dir[0]][j+dir[1]].dead == false){//If the cell is alive
          alive++;//Add to counter
        }
      }
      catch(ArrayIndexOutOfBoundsException exception){
      }
    }
    return alive;//Return the amount
  }
}
