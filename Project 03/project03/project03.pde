camControl cam = new camControl();

ArrayList<PVector> targets = new ArrayList<PVector>();

PShape sixFan;
PShape twoFan;
PShape box;
PShape monsterS;
PShape monsterL;

void setup(){
  size(1600, 1000, P3D);
  //strokeWeight(1);
  //stroke(0);
  perspective(radians(50.0f), width/(float)height, 0.1, 1000);
  
  cam.AddLookAtTarget(new PVector(0,0,0));
  cam.AddLookAtTarget(new PVector(75,0,0));
  cam.AddLookAtTarget(new PVector(-100,0,0));
  cam.AddLookAtTarget(new PVector(-50,0,0));

  sixFan = createShape();
  sixFan.beginShape(TRIANGLE_FAN);
  sixFan.colorMode(HSB, 360, 100, 100);
  sixFan.stroke(0, 100, 0);
  
  sixFan.fill(0, 100, 100);
  sixFan.vertex(-30, -10, 0);
  sixFan.fill(60, 100, 100);
  sixFan.vertex(-35, 0, 0);
  sixFan.fill(120, 100, 100);
  sixFan.vertex(-45, 0, 0);
  
  sixFan.fill(0, 100, 100);
  sixFan.vertex(-30, -10, 0);
  sixFan.fill(120, 100, 100);
  sixFan.vertex(-45, 0, 0);
  sixFan.fill(180, 100, 100);
  sixFan.vertex(-50, -10, 0);
  
  sixFan.fill(0, 100, 100);
  sixFan.vertex(-30, -10, 0);
  sixFan.fill(180, 100, 100);
  sixFan.vertex(-50, -10, 0);
  sixFan.fill(240, 100, 100);
  sixFan.vertex(-45, -20, 0);
  
  sixFan.fill(0, 100, 100);
  sixFan.vertex(-30, -10, 0);
  sixFan.fill(240, 100, 100);
  sixFan.vertex(-45, -20, 0);
  sixFan.fill(300, 100, 100);
  sixFan.vertex(-35, -20, 0);
  
  sixFan.colorMode(RGB, 255, 255, 255);
  sixFan.endShape(CLOSE);
  
  twoFan = createShape();
  twoFan.beginShape(TRIANGLE_FAN);
  twoFan.colorMode(HSB, 360, 100, 100);
  twoFan.stroke(0, 100, 0);
 
  float degrees = 360.0f / 20;
  float angle = degrees; 
  for(int i = 0; i < 18; i++){
    twoFan.fill(0, 100, 100);
    twoFan.vertex(-50, -10, 0);
    twoFan.fill(angle, 100, 100);
    twoFan.vertex(-60 + (10 * cos(radians(angle))), -10 + (10 * sin(radians(angle))));
    angle += degrees;
    twoFan.fill(angle, 100, 100);
    twoFan.vertex(-60 + (10 * cos(radians(angle))), -10 + (10 * sin(radians(angle))));
    
  }
  twoFan.colorMode(RGB, 255, 255, 255);
  twoFan.endShape(CLOSE);
  
  monsterS = loadShape("monster.obj");
  monsterS.setFill(color(195, 228, 60));
  
  monsterL = loadShape("monster.obj");
  
  
  
  box = createShape();
  box.beginShape(TRIANGLE);
  box.colorMode(HSB, 360, 100, 100);
  box.noStroke();
  
  box.fill(60, 100, 100);
  box.vertex(-0.5, -0.5, 0.5);
  box.vertex(-0.5, 0.5, 0.5);
  box.vertex(0.5, 0.5, 0.5);
  
  box.fill(120, 100, 100);
  box.vertex(-0.5, -0.5, 0.5);
  box.vertex(0.5, -0.5, 0.5);
  box.vertex(0.5, 0.5, 0.5);
  
  box.fill(120, 100, 100);
  box.vertex(-0.5, -0.5, -0.5);
  box.vertex(-0.5, 0.5, -0.5);
  box.vertex(0.5, 0.5, -0.5);
  
  box.fill(0, 100, 100);
  box.vertex(-0.5, -0.5, -0.5);
  box.vertex(0.5, -0.5, -0.5);
  box.vertex(0.5, 0.5, -0.5);
  
  box.fill(60, 100, 100);
  box.vertex(-0.5, -0.5, -0.5);
  box.vertex(-0.5, 0.5, 0.5);
  box.vertex(-0.5, 0.5, -0.5);
  
  box.fill(240, 100, 100);
  box.vertex(-0.5, -0.5, 0.5);
  box.vertex(-0.5, -0.5, -0.5);
  box.vertex(-0.5, 0.5, 0.5);
  
  box.fill(0, 100, 100);
  box.vertex(0.5, -0.5, 0.5);
  box.vertex(0.5, -0.5, -0.5);
  box.vertex(0.5, 0.5, 0.5);
  
  box.fill(240, 100, 100);
  box.vertex(0.5, -0.5, -0.5);
  box.vertex(0.5, 0.5, 0.5);
  box.vertex(0.5, 0.5, -0.5);
  
  box.fill(0, 100, 100);
  box.vertex(-0.5, -0.5, 0.5);
  box.vertex(0.5, -0.5, 0.5);
  box.vertex(-0.5, -0.5, -0.5);
  
  box.fill(60, 100, 100);
  box.vertex(0.5, -0.5, -0.5);
  box.vertex(0.5, -0.5, 0.5);
  box.vertex(-0.5, -0.5, -0.5);
  
  box.fill(0, 100, 100);
  box.vertex(-0.5, 0.5, 0.5);
  box.vertex(0.5, 0.5, 0.5);
  box.vertex(-0.5, 0.5, -0.5);
  
  box.fill(300, 100, 100);
  box.vertex(0.5, 0.5, -0.5);
  box.vertex(0.5, 0.5, 0.5);
  box.vertex(-0.5, 0.5, -0.5);
  
  box.colorMode(RGB, 255, 255, 255);
  box.endShape(CLOSE);
  
  
 
  
  
}

void draw(){
  cam.Update();
  background(50);
  
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
  
  shape(sixFan);
  shape(twoFan);
  
  pushMatrix();
  scale(0.5, -0.5, 0.5);
  shape(monsterS);
  popMatrix();
  
  pushMatrix();
  translate(75, 0, 0);
  scale(1, -1, 1);
  monsterL.setFill(color(0,0,0,0));
  monsterL.setStroke(true);
  monsterL.setStroke(color(0));
  monsterL.setStrokeWeight(2.0f);
  shape(monsterL);
  popMatrix();
  
  translate(-100, 0, 0);
  pushMatrix();
  scale(5, 5, 5);
  shape(box);
  popMatrix();
  
  pushMatrix();
  translate(-10, 0, 0);
  shape(box);
  popMatrix();
  
  pushMatrix();
  translate(10, 0, 0);
  scale(10,20,10);
  shape(box);
  popMatrix();
  
  
  
  camera(cam.xCam + cam.xTar, cam.yCam + cam.yTar, cam.zCam + cam.zTar, cam.xTar, cam.yTar, cam.zTar, 0, 1, 0);
}



class camControl{
  
  float xCam = 45.0f;
  float yCam = -45.0f;
  float zCam = 45.0f;
  
  int curTar = 0;
  float xTar = 0.0f;
  float yTar = 0.0f;
  float zTar = 0.0f;
  
  int radius = 100;
  
  void Update(){
    float phi = radians(map(mouseX, 0, (width - 1), 0, 360));
    float theta = radians(map(mouseY, 0, (height - 1), 1, 179));
    xCam = radius * cos(phi) * sin(theta);
    yCam = radius * cos(theta);
    zCam = radius * sin(theta) * sin(phi);
    println(degrees(phi), degrees(theta));
  }
  
  void AddLookAtTarget(PVector tar){
    targets.add(tar);
  }
  
  void CycleTarget(){
    curTar = (curTar + 1) % 4;
    xTar = targets.get(curTar).x;
    yTar = targets.get(curTar).y;
    zTar = targets.get(curTar).z;
    
  }
  
  void Zoom(float val){
    int check = radius + (10 * int(val));
    if(check >= 30 && check <= 200){
      radius = check;
      
    }
  }
}

void keyPressed(){
  if(key == ' '){
    cam.CycleTarget();
  }
}

void mouseWheel(MouseEvent event){
  float e = event.getCount();
  cam.Zoom(e);
}
