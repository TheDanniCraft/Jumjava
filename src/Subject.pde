class Subject{
  int w,h;
  float x,y,vx,vy;
  
  float accelleration_x, accelleration_y, speedLimit;
  
  float friction, bounce, gravity;
  
  boolean isOnGround;
  
  float jumpForce, halfWidth, halfHeight;
  
  String collisionSide;
  
  Subject(){
    w = 50;
    h = 50;
    
    x = width / 2;
    y = 200;
    
    vx = 0;
    vy = 0;
    
    accelleration_x = 0;
    accelleration_y = 0;
    
    speedLimit = 5;
    isOnGround = false;
    jumpForce = -20;
    friction = 0.96;
    bounce = -0.7;
    gravity = 3;
    halfWidth = w/2;
    halfHeight = h/2;
    collisionSide = "";
    
  }
  
  void update(){
    if(right && !left) accelleration_x = 0.2;
    if(!right && left) accelleration_x = -0.2;
    if(!right && !left) accelleration_x = 0;
    
    if(space && isOnGround){
      vy = vy + jumpForce; 
      jump.play();
      isOnGround = false;
    }
    
    if(!left && !right){
      gravity = 0.3;
    }

    vx = vx + accelleration_x;
    vy = vy + accelleration_y;
    
    vx = vx * friction;
    vy = vy * friction;
    
    vy = vy  + gravity;
    
    if(vx > speedLimit) vx = speedLimit;
    if(vx < -speedLimit) vx = -speedLimit;
    
    x = x + vx;
    y = y + vy;
    
    checkPlatforms();
    checkBoundaries(); 
  }
  
  void checkBoundaries(){
    collisionSide = "";
    
    if(x < 0){
      vx = vx * bounce;
      x = 0;
      collisionSide = "Left";
    }
    
    if(y < 0){
      vy = vy * bounce;
      y = 0;
      collisionSide = "Top";
    }
    
    if(x + w > width){
      vx = vx * bounce;
      x = width - w;
      collisionSide = "Right";
    }
    
    if(y + h > height){
      if(vy < 1){
        isOnGround = true;
        vy = 0;
      }
      else{
        vy = vy * bounce / 2;
      }
      y = height - h;
      collisionSide = "Down";
    }
  }
  
  void checkPlatforms() {
    if (collisionSide == "bottom"  && vy >= 0) {
      if (abs(vy) < 1) {
        isOnGround = true;
        vy = 0;
      } else {
        vy *= 0;
      }
    } else if (collisionSide == "top" && vy <= 0) {
      vy = 0;
    } else if (collisionSide == "right" && vx >= 0) {
      vx = 0;
    } else if (collisionSide == "left" && vx <= 0) {
      vx = 0;
    }
    if (collisionSide != "bottom" && vy > 0) {
      isOnGround = false;
    }
  }
  
  void  display(){
    fill(0, 255, 0, 128);
    
    image(player, x, y);
    if(vx >= 0){
    
    }
    else{
    
    }
  }
}
