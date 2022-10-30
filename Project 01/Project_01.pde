import controlP5.*;
ControlP5 cp5;
int iterations;
int speed;
int stepCount;
float strokeColor;
int xSize = 800;
int ySize = 800;
int xPos = xSize / 2;
int yPos = ySize / 2;
boolean run = false;

void setup() {
  size(800, 800);
  background(140, 170, 210);
  iterations = 500000;
  speed = 1000;
  stepCount = 0;
  strokeColor = 0;
  
  cp5 = new ControlP5(this);
  
  cp5.addButton("Start")
  .setPosition(10,25)
  .setSize(100,25)
  .activateBy(ControlP5.PRESSED)
  ;
  
  
}

void draw() {
  if(run == true){
    Step(speed);
  }
  
}

public void Start(){
  println("Button Pressed");
  background(140, 170, 210);
  xPos = xSize / 2;
  yPos = ySize / 2;
  strokeColor = 0;
  run = true;
}

public void Step(int speed){
  for(int i = 0; i < speed; i++){
     if(run == true){
      stroke(strokeColor);
      point(xPos, yPos);
      stepCount += 1;
      if(stepCount == iterations){
       run = false;
      }
      incrementColor();
      incrementPos();
    }
  }
}


public void incrementColor(){
  float increment = 255.0 / iterations;
  strokeColor += increment;
  println(strokeColor);
}

public void incrementPos(){
  int direction = int(random(0,4));
  
  if(direction == 0){ //North
    if(yPos == 0){
      yPos++;
    }
    else{
      yPos--;
    }
  }
  else if(direction == 1){ //South
     if(yPos == ySize){
      yPos--;
    }
    else{
      yPos++;
    }
  }
  else if(direction == 2){ //East
    if(xPos == xSize){
      xPos--;
    }
    else{
      xPos++;
    }
  }
  else if(direction == 3){ //West
    if(xPos == 0){
      xPos++;
    }
    else{
      xPos--;
    }
  }
}
