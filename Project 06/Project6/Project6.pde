// VertexAnimation Project - Student Version
import java.io.*;
import java.util.*;
camControl cam = new camControl();

/*========== Monsters ==========*/
Animation monsterAnim;
ShapeInterpolator monsterForward = new ShapeInterpolator();
ShapeInterpolator monsterReverse = new ShapeInterpolator();
ShapeInterpolator monsterSnap = new ShapeInterpolator();

/*========== Sphere ==========*/
Animation sphereAnim; // Load from file
Animation spherePos; // Create manually
ShapeInterpolator sphereForward = new ShapeInterpolator();
PositionInterpolator spherePosition = new PositionInterpolator();

// TODO: Create animations for interpolators
ArrayList<PositionInterpolator> cubes = new ArrayList<PositionInterpolator>();
//PositionInterpolator cubeee = new PositionInterpolator();
//Animation cubeAnim = new Animation();






void setup()
{
  pixelDensity(2);
  size(1200, 800, P3D);
 
  /*====== Load Animations ======*/
  monsterAnim = ReadAnimationFromFile("monster.txt");
  sphereAnim = ReadAnimationFromFile("sphere.txt");

  monsterForward.SetAnimation(monsterAnim);
  monsterReverse.SetAnimation(monsterAnim);
  monsterSnap.SetAnimation(monsterAnim);  
  monsterSnap.SetFrameSnapping(true);

  sphereForward.SetAnimation(sphereAnim);

  /*====== Create Animations For Cubes ======*/
  // When initializing animations, to offset them
  // you can "initialize" them by calling Update()
  // with a time value update. Each is 0.1 seconds
  // ahead of the previous one
  for(int i = 0; i < 220; i += 20){
    Animation cubeAnim = new Animation();
      //Key[0]
  KeyFrame key0 = new KeyFrame();
  key0.time = 0.5;
  key0.points.add(new PVector(-100 + i, 0, 0));
  cubeAnim.keyFrames.add(key0);
  
    //Key[1]
  KeyFrame key1 = new KeyFrame();
  key1.time = 1.0;
  key1.points.add(new PVector(-100 + i, 0, 90));
  cubeAnim.keyFrames.add(key1);
  
    //Key[2]
  KeyFrame key2 = new KeyFrame();
  key2.time = 1.5;
  key2.points.add(new PVector(-100 + i, 0, 0));
  cubeAnim.keyFrames.add(key2);
  
    //Key[3]
  KeyFrame key3 = new KeyFrame();
  key3.time = 2.0;
  key3.points.add(new PVector(-100 + i, 0, -90));
  cubeAnim.keyFrames.add(key3);
  
  PositionInterpolator tempInter = new PositionInterpolator();
  tempInter.SetAnimation(cubeAnim);
  cubes.add(tempInter);
  }
  cubes.get(2).Update(0);
  cubes.get(2).Update(0);
  cubes.get(3).Update(0);
  cubes.get(4).Update(0);
  cubes.get(5).Update(0);
  cubes.get(6).Update(0);
  cubes.get(7).Update(0);
  cubes.get(8).Update(0);
  cubes.get(9).Update(0);
  
  
  
  cubes.get(2).Update(0.25);//red
  cubes.get(3).Update(0.4);
  cubes.get(4).Update(0.5);//red
  cubes.get(5).Update(0.8);
  cubes.get(6).Update(0.75);//red
  cubes.get(7).Update(1.25);
  cubes.get(8).Update(1.0);//red
  cubes.get(9).Update(1.70);
  
  /*====== Create Animations For Spheroid ======*/
  Animation spherePos = new Animation();
  // Create and set keyframes
    //Key[0]
  KeyFrame key0 = new KeyFrame();
  key0.time = 1.0;
  key0.points.add(new PVector(-100, 0, 100));
  spherePos.keyFrames.add(key0);
  
    //Key[1]
  KeyFrame key1 = new KeyFrame();
  key1.time = 2.0;
  key1.points.add(new PVector(-100, 0, -100));
  spherePos.keyFrames.add(key1);
  
    //Key[2]
  KeyFrame key2 = new KeyFrame();
  key2.time = 3.0;
  key2.points.add(new PVector(100, 0, -100));
  spherePos.keyFrames.add(key2);
  
    //Key[3]
  KeyFrame key3 = new KeyFrame();
  key3.time = 4.0;
  key3.points.add(new PVector(100, 0, 100));
  spherePos.keyFrames.add(key3);
  
  
  spherePosition.SetAnimation(spherePos);
  
  

  
}

void draw()
{
  lights();
  cam.Update();
  background(0);
  DrawGrid();


  float playbackSpeed = 0.005f;

  // TODO: Implement your own camera


  /*====== Draw Forward Monster ======*/
  pushMatrix();
  translate(-40, 0, 0);
  monsterForward.fillColor = color(128, 200, 54);
  monsterForward.Update(playbackSpeed);
  shape(monsterForward.currentShape);
  popMatrix();
  
  /*====== Draw Reverse Monster ======*/
  pushMatrix();
  translate(40, 0, 0);
  monsterReverse.fillColor = color(220, 80, 45);
  monsterReverse.Update(-playbackSpeed);
  shape(monsterReverse.currentShape);
  popMatrix();
  
  /*====== Draw Snapped Monster ======*/
  pushMatrix();
  translate(0, 0, -60);
  monsterSnap.snapping = true;
  monsterSnap.fillColor = color(160, 120, 85);
  monsterSnap.Update(playbackSpeed);
  shape(monsterSnap.currentShape);
  popMatrix();
  
  /*====== Draw Spheroid ======*/
  spherePosition.Update(playbackSpeed);
  sphereForward.fillColor = color(39, 110, 190);
  sphereForward.Update(playbackSpeed);
  PVector pos = spherePosition.currentPosition;
  pushMatrix();
  translate(pos.x, pos.y,pos.z);
  shape(sphereForward.currentShape);
  popMatrix();
  

 
  
  /*====== TODO: Update and draw cubes ======*/
  // For each interpolator, update/draw
  PositionInterpolator temp;
  
  //Cube01
  temp = cubes.get(0);
  temp.Update(playbackSpeed);
  pushMatrix();
  translate(temp.currentPosition.x, temp.currentPosition.y, temp.currentPosition.z);
  noStroke();
  fill(255,0,0);
  box(10);
  popMatrix();
  
  //Cube02
  temp = cubes.get(1);
  temp.SetFrameSnapping(true);
  temp.Update(playbackSpeed);
  pushMatrix();
  translate(temp.currentPosition.x, temp.currentPosition.y, temp.currentPosition.z);
  noStroke();
  fill(255,255,0);
  box(10);
  popMatrix();
  
  //Cube03
  temp = cubes.get(2);
  temp.Update(playbackSpeed);
  
  pushMatrix();
  translate(temp.currentPosition.x, temp.currentPosition.y, temp.currentPosition.z);
  noStroke();
  fill(255,0,0);
  box(10);
  popMatrix();
  
  //Cube04
  temp = cubes.get(3);
  temp.SetFrameSnapping(true);
  temp.Update(playbackSpeed);
  
  pushMatrix();
  translate(temp.currentPosition.x, temp.currentPosition.y, temp.currentPosition.z);
  noStroke();
  fill(255,255,0);
  box(10);
  popMatrix();
  
  //Cube05
  temp = cubes.get(4);
  temp.Update(playbackSpeed);
  
  pushMatrix();
  translate(temp.currentPosition.x, temp.currentPosition.y, temp.currentPosition.z);
  noStroke();
  fill(255,0,0);
  box(10);
  popMatrix();
  
  //Cube06
  temp = cubes.get(5);
  temp.SetFrameSnapping(true);
  temp.Update(playbackSpeed);
  
  pushMatrix();
  translate(temp.currentPosition.x, temp.currentPosition.y, temp.currentPosition.z);
  noStroke();
  fill(255,255,0);
  box(10);
  popMatrix();
  
  //Cube07
  temp = cubes.get(6);
  temp.Update(playbackSpeed);
  
  pushMatrix();
  translate(temp.currentPosition.x, temp.currentPosition.y, temp.currentPosition.z);
  noStroke();
  fill(255,0,0);
  box(10);
  popMatrix();
  
  //Cube08
  temp = cubes.get(7);
  temp.SetFrameSnapping(true);
  temp.Update(playbackSpeed);
  
  pushMatrix();
  translate(temp.currentPosition.x, temp.currentPosition.y, temp.currentPosition.z);
  noStroke();
  fill(255,255,0);
  box(10);
  popMatrix();
  
  //Cube09
  temp = cubes.get(8);
  temp.Update(playbackSpeed);
  
  pushMatrix();
  translate(temp.currentPosition.x, temp.currentPosition.y, temp.currentPosition.z);
  noStroke();
  fill(255,0,0);
  box(10);
  popMatrix();
  
  //Cube10
  temp = cubes.get(9);
  temp.SetFrameSnapping(true);
  temp.Update(playbackSpeed);
  
  pushMatrix();
  translate(temp.currentPosition.x, temp.currentPosition.y, temp.currentPosition.z);
  noStroke();
  fill(255,255,0);
  box(10);
  popMatrix();
  
  //Cube11
  temp = cubes.get(10);
  temp.SetFrameSnapping(false);
  temp.Update(playbackSpeed);
  
  pushMatrix();
  translate(temp.currentPosition.x, temp.currentPosition.y, temp.currentPosition.z);
  noStroke();
  fill(255,0,0);
  box(10);
  popMatrix();
  
  
  camera();
  perspective();
}


void mouseWheel(MouseEvent event)
{
  float e = event.getCount();
  // Zoom the camera
  // SomeCameraClass.zoom(e);
    cam.Zoom(e);
  
}

// Create and return an animation object
Animation ReadAnimationFromFile(String fileName)
{
  Animation animation = new Animation();

  int numFrames;
  int numVerts;
  
   //The BufferedReader class will let you read in the file data
  try
  {
    BufferedReader reader = createReader(fileName);
    numFrames = int(reader.readLine());
    numVerts = int(reader.readLine());
    
    for(int i = 0; i < numFrames; i++){
      KeyFrame tempKey = new KeyFrame();
      tempKey.time = float(reader.readLine());
      for(int j = 0; j < numVerts; j++){
        String[] pos = split(reader.readLine(), " ");
        tempKey.points.add(new PVector(float(pos[0]), float(pos[1]), float(pos[2])));
      }
      animation.keyFrames.add(tempKey);
    }
  }
  catch (FileNotFoundException ex)
  {
    println("File not found: " + fileName);
  }
  catch (IOException ex)
  {
    ex.printStackTrace();
  }
 
  return animation;
}

void DrawGrid()
{
  // TODO: Draw the grid
  // Dimensions: 200x200 (-100 to +100 on X and Z)
    for(int i = -100; i <= 100; i = i + 10){
    if(i == 0){
      stroke(255,0,0);
      line(-100, 0, i, 100, 0, i);
      stroke(0, 0, 255);
      line(i, 0, -100, i, 0, 100);
      stroke(255);
    }
    else{
      stroke(255);
      line(-100, 0, i, 100, 0, i);
      line(i, 0, -100, i, 0, 100);
    }
    
  }
}

//Camera Class
class camControl{
  
  float xCam = 45.0f;
  float yCam = -45.0f;
  float zCam = 45.0f;
  
  int curTar = 0;
  float xTar = 0.0f;
  float yTar = 0.0f;
  float zTar = 0.0f;
  
  int radius = 200;
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
    int check = radius + (5 * int(val));
    if(check >= 10 && check <= 200){
      radius = check;
    }
  }
}

void mouseDragged(){
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
