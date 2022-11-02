import controlP5.*;
ControlP5 cp5;
camControl cam = new camControl();
ArrayList<PVector> points;
ArrayList<Integer> triangles;
float gridSize;
int rows;
int cols;

void setup(){
  size(1200, 800, P3D);
  cp5 = new ControlP5(this);
  
  cp5.addSlider("ROWS")
  .setPosition(20,20)
  .setRange(1,100)
  .setDecimalPrecision(0)
  .setValue(10);
  ;
  
  cp5.addSlider("COLUMNS")
  .setPosition(20,40)
  .setRange(1,100)
  .setDecimalPrecision(0)
  .setValue(10);
  ;
  
  cp5.addSlider("TERRAIN SIZE")
  .setPosition(20,60)
  .setRange(20,50)
  .setValue(30.00)
  ;
  
  cp5.addButton("GENERATE")
  .setPosition(20,100)
  .setSize(80,25)
 ;
  
 cp5.addTextfield("LOAD FROM FILE")
 .setPosition(20,140)
 .setText("terrain1")
 ;
 
 cp5.addToggle("STROKE")
 .setPosition(250, 20)
 .setValue(true)
 ;

 cp5.addToggle("COLOR")
 .setPosition(300, 20)
 .setValue(false)
 ;

 cp5.addToggle("BLEND")
 .setPosition(350, 20)
 .setValue(false)
 ;

  cp5.addSlider("HEIGHT MODIFIER")
  .setPosition(250,70)
  .setRange(1,100)
  .setDecimalPrecision(0)
  .setValue(10);
  ;
  
  cp5.addSlider("SNOW THRESHOLD")
  .setPosition(250,90)
  .setRange(1,100)
  .setDecimalPrecision(0)
  .setValue(10);
  ;

  
  gridSize = 30.0;
  rows = 10;
  cols = 10;

  buildGrid();
  buildTriangleVerts();



}

void draw(){
  cam.Update();

  background(50);
  /*
  //old grid
  strokeWeight(10);
  for(int i = 0; i < points.size(); i++){ //Draws grids as points
    PVector temp = points.get(i);
    stroke(map(temp.x, -(gridSize/2), gridSize/2, 0, 255), 0, map(temp.z, -(gridSize/2), gridSize/2, 0, 255));
    point(temp.x, temp.y, temp.z);
  }
  */
  
  
  beginShape(TRIANGLES); //<>//
  
  for(int i = 0; i < triangles.size(); i++){
    int vertIndex = triangles.get(i);
    PVector vert = points.get(vertIndex);
    
    vertex(vert.x, vert.y, vert.z);
  }
  
  endShape();
 
  
  
  
  
  camera();
  perspective();
}



class camControl{
  
  float xCam = 45.0f;
  float yCam = -45.0f;
  float zCam = 45.0f;
  
  int curTar = 0;
  float xTar = 0.0f;
  float yTar = 0.0f;
  float zTar = 0.0f;
  
  int radius = 30;
  float phi = radians(90);
  float theta = radians(140);
  
  void Update(){
    perspective(radians(90.0f), width/(float)height, 0.1, 1000);
    camera(cam.xCam + cam.xTar, cam.yCam + cam.yTar, cam.zCam + cam.zTar, cam.xTar, cam.yTar, cam.zTar, 0, 1, 0);
    
    //float phi = radians(map(mouseX, 0, (width - 1), 0, 360));
    //float theta = radians(map(mouseY, 0, (height - 1), 1, 179));
    

    xCam = radius * cos(phi) * sin(theta);
    yCam = radius * cos(theta);
    zCam = radius * sin(theta) * sin(phi);
  }
  

  

  
  void Zoom(float val){
    int check = radius + (10 * int(val));
    if(check >= 30 && check <= 200){
      radius = check;
    }
  }
}


void buildGrid(){
  
  points = new ArrayList();
  
  /*
  float startX = -(gridSize / 2);
  float startZ = -(gridSize / 2);
  float rowInc = gridSize / rows;
  float colInc = gridSize / cols;
  
  while(startZ <= (gridSize / 2)){
    float z = startZ;
    while(startX <= (gridSize / 2)){
      float x = startX;
      float y = 0;
      startX += colInc;
      points.add(new PVector(x,y,z));
      
    }
    startZ += rowInc;
    startX = -(gridSize / 2);
  }
  */
  for(int i = 0; i <= rows; i++){
    for(int j = 0; j <= cols; j++){
      float z = (-(gridSize/2) + (gridSize/rows) * i);
      float y = 0;
      float x = (-(gridSize/2) + (gridSize/cols) * j);
      
      points.add(new PVector(x,y,z));
      println(x,y,z);
    }
  }
  
  println("points on grid:", points.size());
}

void buildTriangleVerts(){ //<>//
  triangles = new ArrayList();
  int vertsInRow = cols + 1;
  
  for(int i = 0; i < rows; i++){
    for(int j = 0; j < cols; j++){
    //upper
    triangles.add((vertsInRow * i + j));
    triangles.add((vertsInRow * i + j) + 1);
    triangles.add((vertsInRow * i + j) + vertsInRow);
    
    
    //lower
    triangles.add((vertsInRow * i + j) + 1);
    triangles.add((vertsInRow * i + j) + vertsInRow + 1);
    triangles.add((vertsInRow * i + j) + vertsInRow);
    
    }
  }
  println("triangle verts:", triangles.size());
}


public void controlEvent(ControlEvent event){
  if(event.isController()){
    if(event.getController().getName() == "GENERATE"){
      buildGrid();
      buildTriangleVerts();
    }
    else if(event.getController().getName() == "ROWS"){
      rows = int(event.getController().getValue());
    }
    else if(event.getController().getName() == "COLUMNS"){
      cols = int(event.getController().getValue());
    }
    else if(event.getController().getName() == "TERRAIN SIZE"){
      gridSize = event.getController().getValue();
    }
  }
}


void mouseWheel(MouseEvent event){
  float e = event.getCount();
  cam.Zoom(e);
}

void mouseDragged(){
  if(cp5.isMouseOver()){
    return;
  }
  else{
    float deltaX = (mouseX - pmouseX) * 0.015f;
    float deltaY = (mouseY - pmouseY) * 0.015f;

    cam.phi += deltaX;
    cam.theta += deltaY;
    
    
    if(cam.theta > radians(179)){
    cam.theta = radians(179);
    }
    if(cam.theta < radians(1)){
    cam.theta = radians(1);
    }
  }
  println(degrees(cam.phi), degrees(cam.theta));
}
