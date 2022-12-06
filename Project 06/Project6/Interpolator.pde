abstract class Interpolator
{
  Animation animation;
  
  // Where we at in the animation?
  float currentTime = 0;
  
  // To interpolate, or not to interpolate... that is the question
  boolean snapping = false;
  
  void SetAnimation(Animation anim)
  {
    animation = anim;
  }
  
  void SetFrameSnapping(boolean snap)
  {
    snapping = snap;
  }
  
  void UpdateTime(float time)
  {
    // TODO: Update the current time
    // Check to see if the time is out of bounds (0 / Animation_Duration)
    // If so, adjust by an appropriate amount to loop correctly
    currentTime += time;
    if(currentTime > animation.GetDuration()){
      currentTime = 0;
    }
    else if(currentTime < 0){
      currentTime = animation.GetDuration();
    }
    
  }
  
  // Implement this in derived classes
  // Each of those should call UpdateTime() and pass the time parameter
  // Call that function FIRST to ensure proper synching of animations
  abstract void Update(float time);
}

class ShapeInterpolator extends Interpolator
{
  // The result of the data calculations - either snapping or interpolating
  PShape currentShape;
  
  // Changing mesh colors
  color fillColor;
  boolean snapping = false;
  PShape GetShape()
  {
    return currentShape;
  }
  
  void Update(float time)
  {
    // TODO: Create a new PShape by interpolating between two existing key frames
    // using linear interpolation
    UpdateTime(time);
        
    
    int prevFrame=0;
    int nextFrame=1;
    
    
    for(int i = 0; i < animation.keyFrames.size(); i++){
      if(currentTime == animation.keyFrames.get(i).time){
        prevFrame = i;
        nextFrame = (i+1)%(animation.keyFrames.size());
      }
      else if(currentTime > animation.keyFrames.get(i).time && currentTime < animation.keyFrames.get((i+1)%(animation.keyFrames.size())).time){
        prevFrame = i;
        nextFrame = (i+1)%(animation.keyFrames.size());
      }
      else if(currentTime < animation.keyFrames.get(0).time){
        prevFrame = animation.keyFrames.size() - 1;
        nextFrame = (i+1)%(animation.keyFrames.size());
      }
    }
    
    float prevTime = animation.keyFrames.get(prevFrame).time;
    float nextTime = animation.keyFrames.get(nextFrame).time;
      
    float ratio = (currentTime - prevTime) / (nextTime - prevTime);
    if(ratio > 1.0){
      ratio = currentTime / nextTime;
    }
    KeyFrame prevPos = animation.keyFrames.get(prevFrame);
    KeyFrame nextPos = animation.keyFrames.get(nextFrame);
    //currentShape = new PVector(prevPos.x, prevPos.y, lerp(prevPos.z, nextPos.z, ratio));
    
    
    if(snapping){
      PShape tempShape = createShape();
      tempShape.beginShape(TRIANGLES);
      tempShape.fill(fillColor);
      tempShape.noStroke();
      ArrayList<PVector> prevPoints = prevPos.points;
      for(int i = 0; i < prevPoints.size(); i++){
      
        tempShape.vertex(prevPoints.get(i).x, prevPoints.get(i).y, prevPoints.get(i).z);             
      }
      tempShape.endShape(CLOSE);
    
      currentShape = tempShape;
    }
    
    else{
    PShape tempShape = createShape();
    tempShape.beginShape(TRIANGLES);
    tempShape.fill(fillColor);
    tempShape.noStroke();
    ArrayList<PVector> prevPoints = prevPos.points;
    ArrayList<PVector> nextPoints = nextPos.points;
    for(int i = 0; i < prevPoints.size(); i++){
      
      tempShape.vertex(lerp(prevPoints.get(i).x, nextPoints.get(i).x, ratio), lerp(prevPoints.get(i).y, nextPoints.get(i).y, ratio), lerp(prevPoints.get(i).z, nextPoints.get(i).z, ratio));             
    }
    tempShape.endShape(CLOSE);
    
    currentShape = tempShape;
    }
  }
}

class PositionInterpolator extends Interpolator
{
  PVector currentPosition;
  
  
  
  void Update(float time)
  {
    UpdateTime(time);
    //println(currentTime);
    
    int prevFrame=0;
    int nextFrame=1;
    
    
    for(int i = 0; i < animation.keyFrames.size(); i++){
      if(currentTime == animation.keyFrames.get(i).time){
        prevFrame = i;
        nextFrame = (i+1)%4;
      }
      else if(currentTime > animation.keyFrames.get(i).time && currentTime < animation.keyFrames.get((i+1)%4).time){
        prevFrame = i;
        nextFrame = (i+1)%4;
      }
      else if(currentTime < animation.keyFrames.get(0).time){
        prevFrame = animation.keyFrames.size() - 1;
        nextFrame = (i+1)%4;
      }
    }
    //println(prevFrame,nextFrame);
    
    
    // The same type of process as the ShapeInterpolator class... except
    // this only operates on a single point
    
    if(snapping){
      currentPosition = animation.keyFrames.get(prevFrame).points.get(0);
    }
    else{
      
      float prevTime = animation.keyFrames.get(prevFrame).time;
      float nextTime = animation.keyFrames.get(nextFrame).time;
      
      float ratio = (currentTime - prevTime) / (nextTime - prevTime);
      if(ratio > 1.0){
        ratio = currentTime / nextTime;
      }
      PVector prevPos = animation.keyFrames.get(prevFrame).points.get(0);
      PVector nextPos = animation.keyFrames.get(nextFrame).points.get(0);
      currentPosition = new PVector(lerp(prevPos.x, nextPos.x, ratio), prevPos.y, lerp(prevPos.z, nextPos.z, ratio));
    }
  }
}
