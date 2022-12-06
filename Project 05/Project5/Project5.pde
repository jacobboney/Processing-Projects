import java.io.*;    // Needed for BufferedReader
import queasycam.*;
import controlP5.*;

QueasyCam cam;
ControlP5 cp5;
float xPos = 150;
float zPos = 300;
float speed = 1.0f;

ArrayList<Scene> scenes = new ArrayList<Scene>();
int currentScene = 0;
void setup()
{
  size(1200, 1000, P3D);
  pixelDensity(2);
  perspective(radians(60.0f), width/(float)height, 0.1, 1000);
  
  cp5 = new ControlP5(this);
  cp5.addButton("ChangeScene").setPosition(10, 10);
  
  cam = new QueasyCam(this);
  cam.speed = 0;
  cam.sensitivity = 0;
  cam.position = new PVector(0, -50, 100);

  // TODO: Load scene files here (testfile, scene 1, and scene 2)
  scenes.add(new Scene("scenes/scene1.txt"));
  scenes.add(new Scene("scenes/scene2.txt"));
  
  
  
  lights(); // Lights turned on once here
}

void draw()
{
  // Use lights, and set values for the range of lights. Scene gets REALLY bright with this commented out...
  lightFalloff(1.0, 0.001, 0.0001);
  perspective(radians(60.0f), width/(float)height, 0.1, 2000);
  pushMatrix();
  rotateZ(radians(180)); // Flip everything upside down because Processing uses -y as up
  
  // TODO: Draw the current scene
  background(scenes.get(currentScene).background);
  
  for(int i = 0 ; i < scenes.get(currentScene).GetLightCount(); i++){
    PVector pos = scenes.get(currentScene).lightLocs.get(i);
    PVector vals = scenes.get(currentScene).lightColors.get(i);
    pointLight(vals.x, vals.y, vals.z, pos.x, pos.y, pos.z);
  }
  
  for(int i = 0; i < scenes.get(currentScene).GetShapeCount(); i++){
    PShape mesh = scenes.get(currentScene).objects.get(i);
    PVector loc = scenes.get(currentScene).objectLocs.get(i);
    PVector col = scenes.get(currentScene).objectColors.get(i);
    
    pushMatrix();
    translate(loc.x, loc.y, loc.z);
    mesh.setFill(color(col.x, col.y, col.z));
    shape(mesh);
    popMatrix();
    
  }


  popMatrix();

  camera();
  perspective();
  noLights(); // Turn lights off for ControlP5 to render correctly
  DrawText();
}

void mousePressed()
{
  if (mouseButton == RIGHT)
  {
    // Enable the camera
    cam.sensitivity = 1.0f; 
    cam.speed = 2;
  }

}

void mouseReleased()
{  
  if (mouseButton == RIGHT)
  {
    // "Disable" the camera by setting move and turn speed to 0
    cam.sensitivity = 0; 
    cam.speed = 0;
  }
}

void ChangeScene()
{
  currentScene++;
  if (currentScene >= scenes.size())
    currentScene = 0;
}

void DrawText()
{
  textSize(30);
  text("PShapes: " + scenes.get(currentScene).GetShapeCount(), 0, 60);
  text("Lights: " + scenes.get(currentScene).GetLightCount(), 0, 90);
}


class Scene{
  Scene(){}
  
  Scene(String fileName){
    objects = new ArrayList();
    objectLocs = new ArrayList();
    objectColors = new ArrayList();
    lightLocs = new ArrayList();
    lightColors = new ArrayList();
    
    BufferedReader reader = createReader(fileName);
    try{
      
      String line = reader.readLine();
      setBackground(line);
      
      line = reader.readLine();
      shapeCount = Integer.parseInt(line);
      for(int i = 0; i < shapeCount; i++){
        line = reader.readLine();
        addObject(line);
      }
      
      line = reader.readLine();
      lightCount = Integer.parseInt(line);
      for(int i = 0; i < lightCount; i++){
        line = reader.readLine();
        addLight(line);
      }
      
    }
    catch(IOException e){
      e.printStackTrace();
    }
  }
  color background;
  int shapeCount;
  int lightCount;
  
  ArrayList<PShape> objects;
  ArrayList<PVector> objectLocs;
  ArrayList<PVector> objectColors;
  
  ArrayList<PVector> lightLocs;
  ArrayList<PVector> lightColors;
  
  void setBackground(String line){
    String vars[] = line.split(",");
    background = color(Integer.parseInt(vars[0]), Integer.parseInt(vars[1]), Integer.parseInt(vars[2]));
  }
  
  void addObject(String line){
    String vars[] = line.split(",");
    objects.add(loadShape("models/" + vars[0] + ".obj"));
    objectLocs.add(new PVector(float(vars[1]), float(vars[2]), float(vars[3])));
    objectColors.add(new PVector(Integer.parseInt(vars[4]), Integer.parseInt(vars[5]), Integer.parseInt(vars[6])));
  }
  
  void addLight(String line){
    String vars[] = line.split(",");
    lightLocs.add(new PVector(float(vars[0]), float(vars[1]), float(vars[2])));
    lightColors.add(new PVector(Integer.parseInt(vars[3]), Integer.parseInt(vars[4]), Integer.parseInt(vars[5])));
  }
  
  int GetShapeCount(){
    return shapeCount;
  }
  
  int GetLightCount(){
    return lightCount;
  }
}
