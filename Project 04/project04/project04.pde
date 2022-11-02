import controlP5.*;
ControlP5 cp5;
camControl cam = new camControl();

//Data storage
ArrayList<PVector> points;
ArrayList<Integer> triangles;

//Adjustable Parameters
float gridSize;
int rows;
int cols;
String fileName;
PImage heightMap;
float heightModifierValue;
float snowThreshold;
boolean COLOR;
boolean STROKE;
boolean BLEND;


//Colors for height map
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
  
 cp5.addTextfield("LOADFILE")
 .setPosition(20,140)
 .setValue("terrain0")
 .setAutoClear(false)
 .setLabel("LOAD FROM FILE")
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

  //Setting default values for parameters
  gridSize = 30.0;
  rows = 10;
  cols = 10;
  fileName = "terrain1";
  heightMap = loadImage(fileName + ".png");
  heightModifierValue = 1.0f;
  snowThreshold = 5.0f;
  
  //Set color values
  snow = color(255,255,255);
  grass = color(143,170,64);
  rock = color(135,135,135);
  dirt = color(160,126,84);
  water = color(0,75,200);
  
  //Calculate initial values
  buildGrid();
  buildTriangleVerts();
  applyHeightMap();

 


}

void draw(){
  cam.Update();

  background(50);
  
  if(STROKE == true){
    stroke(0);
  }
  else{
    noStroke();
  }
  
  
  //Draw triangles
  beginShape(TRIANGLES); //<>//
  for(int i = 0; i < triangles.size(); i++){
    int vertIndex = triangles.get(i);
    PVector vert = points.get(vertIndex);
    float relativeHeight = abs(vert.y * heightModifierValue / (-(snowThreshold)));
    
    if(COLOR == true){
    
      if(relativeHeight > 1.0){
      fill(snow);
      }
      
      else if(relativeHeight <= 1.0f && relativeHeight > 0.8f || relativeHeight > 1.0){
        if(BLEND == true){
          float ratio = (relativeHeight - 0.8f) / 0.2f;
          color blended = lerpColor(rock, snow, ratio);
          fill(blended);
        }
        else{
          fill(snow);
        }
      
    }
    else if(relativeHeight <= 0.8f && relativeHeight > 0.4f){
      if(BLEND == true){
          float ratio = (relativeHeight - 0.4f) / 0.4f;
          color blended = lerpColor(grass, rock, ratio);
          fill(blended);
        }
        else{
          fill(rock);
        }
    }
    else if(relativeHeight <= 0.4f && relativeHeight > 0.2f){
      if(BLEND == true){
          float ratio = (relativeHeight - 0.2f) / 0.2f;
          color blended = lerpColor(dirt, grass, ratio);
          fill(blended);
        }
        else{
          fill(grass);
        }
    }
    else{
      if(BLEND == true){
          float ratio = relativeHeight / 0.2f;
          color blended = lerpColor(water, dirt, ratio);
          fill(blended);
        }
        else{
          fill(water);
        }
    }
    
    }
    else{
      fill(255);
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

void applyHeightMap(){
  
  if(heightMap != null){
  for(int i = 0; i <= rows; i++){
    for(int j = 0; j <= cols; j++){
      float xIndex = map(j, 0, cols + 1, 0, heightMap.width);
      float yIndex = map(i, 0, rows + 1, 0, heightMap.height);
      int HMcolor = heightMap.get(int(xIndex), int(yIndex));
      
      float heightFromColor = map(red(HMcolor), 0, 255, 0, 1.0f);
      int vIndex = i * (cols + 1) + j;
      points.get(vIndex).y = -heightFromColor;
      
    }
  }
  }
}

public void controlEvent(ControlEvent event){
  if(event.isController()){
    if(event.getController().getName() == "GENERATE"){
      buildGrid();
      buildTriangleVerts();
      fileName = cp5.get(Textfield.class, "LOADFILE").getText();
      heightMap = loadImage(fileName + ".png");
      //println(fileName);
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
      applyHeightMap();
    }
    else if(event.getController().getName() == "SNOW THRESHOLD"){
      snowThreshold = event.getController().getValue();
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
