import controlP5.*;
ControlP5 cp5;
Shape shapeObject;
int shapeType;
int maxSteps;
int stepRate;
int stepSize;
float stepScale;
int seedVal;

boolean useSeed;
boolean useColor;
boolean useStroke;
boolean constrainSteps;
boolean walkItOut;


void setup(){
  size(1200,800);
  background(50, 140, 210);
  fill(100);
  
  
  cp5 = new ControlP5(this);
  
  cp5.addButton("START")
  .setColorBackground(color(0,150,0))
  .setPosition(10,10)
  .setSize(100,30)
  //.activateBy(ControlP5.PRESSED)
  .setColorForeground(color(0,200,0))
  .setColorActive(color(0,150,0))
  ;
  
  cp5.addScrollableList("dropdown")
    .setPosition(10, 50)
    .setSize(150, 200)
    .setBarHeight(40)
    .setItemHeight(40)
    .addItem("SQUARES", 0)
    .addItem("HEXAGONS", 1)
    .setValue(0)
    ;

  
  cp5.addSlider("Maximum_Steps")
  .setLabel("Maximum Steps")
  .setPosition(10, 200)
  .setSize(180, 20)
  .setRange(100, 50000)
  .setValue(100)
  .setDecimalPrecision(0)
  ;
  cp5.getController("Maximum_Steps").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(10);
  
  cp5.addSlider("Step_Rate")
  .setLabel("Step Rate")
  .setPosition(10, 250)
  .setSize(180, 20)
  .setRange(1, 1000)
  .setValue(1)
  .setDecimalPrecision(0)
  ;
  cp5.getController("Step_Rate").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(10);
  
  cp5.addSlider("Step_Size")
  .setLabel("Step Size")
  .setPosition(10, 320)
  .setSize(90, 20)
  .setRange(10, 30)
  .setValue(10)
  .setDecimalPrecision(0)
  ;
  cp5.getController("Step_Size").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(10);
  
  cp5.addSlider("Step_Scale")
  .setLabel("Step Scale")
  .setPosition(10, 360)
  .setSize(90, 20)
  .setRange(1.0, 1.5)
  .setValue(1.0)
  ;
  cp5.getController("Step_Scale").getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(10);
  
  cp5.addToggle("Constrain_Steps")
  .setLabel("CONSTRAIN STEPS")
  .setSize(20,20)
  .setPosition(10, 400)
  ;
  
  cp5.addToggle("Simulate_Terrain")
  .setLabel("SIMULATE TERRAIN")
  .setSize(20,20)
  .setPosition(10, 440)
  ;
  
  cp5.addToggle("Use_Stroke")
  .setLabel("USE STROKE")
  .setSize(20,20)
  .setPosition(10, 480)
  ;
  
  cp5.addToggle("Use_Random_Seed")
  .setLabel("USE RANDOM SEED")
  .setSize(20,20)
  .setPosition(10, 520)
  ;
  
  cp5.addTextfield("Seed_Value")
  .setLabel("SEED VALUE")
  .setSize(50, 20)
  .setPosition(110, 520)
  .setInputFilter(ControlP5.INTEGER)
  ;
  
  shapeType = 0;
  maxSteps = 100;
  stepRate = 1;
  stepSize = 10;
  stepScale = 1.0;
  seedVal = 0;
  shapeObject = null;
  useSeed = false;
  useColor = false;
  useStroke = false; 
  constrainSteps = false;
  walkItOut = false;
}

void draw(){
  rect(0,0,200,800);
  if(walkItOut == true){
    shapeObject.drawShape();
  }
  
}

public void controlEvent(ControlEvent event){ //Control flow for user input
  if(event.isController()){
    if(event.getController().getName() == "START"){
      if(shapeType == 0){
        shapeObject = new Square();
        println(shapeType);
        shapeObject.drawShape();
      }
      else{
        shapeObject = new Hexagon();
        println(shapeType);
        shapeObject.drawShape();
      }
      walkItOut = true;
    }
    else if(event.getController().getName() == "Use_Random_Seed"){
      useSeed = boolean(int(event.getController().getValue()));
      println(useSeed);
    }
    else if(event.getController().getName() == "Simulate_Terrain"){
      useColor = boolean(int(event.getController().getValue()));
      println(useColor);
    }
    else if(event.getController().getName() == "Use_Stroke"){
      useStroke = boolean(int(event.getController().getValue()));
      println(useStroke);
    }
    else if(event.getController().getName() == "Constrain_Steps"){
      constrainSteps = boolean(int(event.getController().getValue()));
      println(constrainSteps);
    }
    else if(event.getController().getName() == "dropdown"){
      shapeType = int(event.getController().getValue());
      println(shapeType);
    }
  }
}

class Shape{
  int max_Steps;
  int steps_Taken;
  int step_Distance;
  float step_Scale;
  boolean use_Color;
  boolean use_Stroke;
  int w_Border;
  int h_Border;
  int xPos;
  int yPos;
  int wMin;
  int wMax;
  int hMin;
  int hMax;
  
  Shape(){
    max_Steps = maxSteps;
    steps_Taken = 0;
    step_Distance = int(stepSize * step_Scale);
    step_Scale = stepScale;
    wMin = 200 + int(step_Distance / 2);
    wMax = (width - 1) - int(step_Distance / 2);
    hMin = 0 + int(step_Distance / 2);
    hMax = (height - 1) - int(step_Distance / 2);
    xPos = 800;
    yPos = 400;
  }
  
  void updateShape(){
    
  }
  void drawShape(){
  
  }

}

class Square extends Shape{
  
  Square(){
    
  }
  void drawShape(){
    println("test");
    for(int i = 0; i < stepRate; i++){
      if(walkItOut == true){
        stroke(160, 126, 84);
        rect(xPos,yPos,stepSize,stepSize);
        steps_Taken++;
        incrementPosContain();
        if(steps_Taken == max_Steps){
          walkItOut = false;
        }
      }
    }
  }
  
  void incrementPosContain(){
    int direction = int(random(0,4));
    
    if(direction == 0){
      if((yPos - step_Distance >= hMin)){
        yPos = yPos - step_Distance;
      }
      else{
        yPos = yPos + step_Distance;
      }
    }
    else if(direction == 1){
      if((yPos + step_Distance <= hMax)){
        yPos = yPos + step_Distance;
      }
      else{
        yPos = yPos - step_Distance;
      }
    }
    else if(direction == 2){
      if((xPos - step_Distance >= wMin)){
        xPos = xPos - step_Distance;
      }
      else{
        xPos = xPos + step_Distance;
      }
    }
    else if(direction == 3){
      if((xPos + step_Distance <= wMax)){
        xPos = xPos + step_Distance;
      }
      else{
        xPos = xPos - step_Distance;
      }
    }
  }
  void incrementPos(){
    int direction = int(random(0,4));
    
    if(direction == 0){
      yPos = yPos - step_Distance;
    }
    else if(direction == 1){
      yPos = yPos + step_Distance;
    }
    else if(direction == 2){
      if((xPos - step_Distance >= wMin)){
        xPos = xPos - step_Distance;
      }
      else{
        xPos = xPos + step_Distance;
      }
    }
    else if(direction == 3){
      xPos = xPos + step_Distance;
    }
  }
}

class Hexagon extends Shape{
  Hexagon(){
    
  }
  void drawShape(){
    println("test2");
  }
  
}
