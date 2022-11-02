import controlP5.*;
ControlP5 cp5;
camControl cam = new camControl();
ArrayList<PVector> points;
ArrayList<Integer> triangles;
float gridSize;
int rows;
int cols;
String fileName;
float heightModifierValue;
float snowThreshold;
color snow;
color grass;
color rock;
color dirt;
color water;

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
 .setText("terrain1.png")
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
  .setRange(-5.0f, 5.0f)
  .setDecimalPrecision(2)
  .setValue(1.0f);
  ;
  
  cp5.addSlider("SNOW THRESHOLD")
  .setPosition(250,90)
  .setRange(1.0f,5.0f)
  .setDecimalPrecision(2)
  .setValue(5.0f);
  ;

  fileName = "terrain1.png";
  gridSize = 30.0;
  rows = 10;
  cols = 10;
  heightModifierValue = 1.0f;
  snowThreshold = 5.0f;
  buildGrid();
  buildTriangleVerts();
  applyHeightMap();

  snow = color(255,255,255);
  grass = color(143,170,64);
  rock = color(135,135,135);
  dirt = color(160,126,84);
  water = color(0,75,200);


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
    
    float relativeHeight = abs(vert.y * heightModifierValue / (-(snowThreshold)));
    
    if(relativeHeight <= 1.0f && relativeHeight > 0.8f){
      fill(snow);
    }
    else if(relativeHeight <= 0.8f && relativeHeight > 0.4f){
      fill(rock);
    }
    else if(relativeHeight <= 0.4f && relativeHeight > 0.2f){
      fill(grass);
    }
    else{
      fill(water);
    }
    
    
    
    vertex(vert.x, vert.y * heightModifierValue, vert.z);
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
  
  for(int i = 0; i <= rows; i++){
    for(int j = 0; j <= cols; j++){
      float z = (-(gridSize/2) + (gridSize/rows) * i);
      float y = 0;
      float x = (-(gridSize/2) + (gridSize/cols) * j);
      
      points.add(new PVector(x,y,z));
      
    }
  }
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
}


public void controlEvent(ControlEvent event){
  if(event.isController()){
    if(event.getController().getName() == "GENERATE"){
      buildGrid();
      buildTriangleVerts();
      fileName = cp5.get(Textfield.class, "LOAD FROM FILE").getText();
      println(fileName);
      applyHeightMap();
      
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
    else if(event.getController().getName() == "HEIGHT MODIFIER"){
      heightModifierValue = event.getController().getValue();
    }
    else if(event.getController().getName() == "SNOW THRESHOLD"){
      snowThreshold = event.getController().getValue();
    }
  }
}

void applyHeightMap(){
  PImage heightMap = loadImage(fileName);
  for(int i = 0; i <= rows; i++){
    for(int j = 0; j <= cols; j++){
      float xIndex = map(j, 0, cols + 1, 0, heightMap.width);
      float yIndex = map(i, 0, rows + 1, 0, heightMap.height);
      int HMcolor = heightMap.get(int(xIndex), int(yIndex));
      
      float heightFromColor = map(red(HMcolor), 0, 255, 0, 1.0f);
      int vIndex = i * (cols + 1) + j;
      points.get(vIndex).y = heightFromColor;
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
}
