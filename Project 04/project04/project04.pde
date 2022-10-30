import controlP5.*;
ControlP5 cp5;
camControl cam = new camControl();


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

}

void draw(){
  cam.Update();

  background(0,0,0);
  box(50);
  for(int i = -100; i <= 100; i = i + 10){
    if(i == 0){
      stroke(255,0,0);
      line(-100, 0, i, 100, 0, i);
      stroke(0, 0, 255);
      line(i, 0, -100, i, 0, 100);
      stroke(255);
    }
    else{
      line(-100, 0, i, 100, 0, i);
      line(i, 0, -100, i, 0, 100);
    }
    
  }

  
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
  
  int radius = 200;
  float phi = radians(45);
  float theta = radians(135);
  
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
