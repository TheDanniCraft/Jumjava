import java.util.Map;
import processing.sound.*;

Subject subject;
Platform pf;


PImage bg;
int bgx = 0;
PImage player;
SoundFile jump;

boolean left, right, space;

boolean debug, started;

Map platforms = new HashMap();


void setup() {
  String path = dataPath("").replace("\\src\\data","").replace("/src/data","");
  fullScreen();
  
  left = false;
  right = false;
  space = false;
  
  println(path);
  
  subject = new Subject();
  
  surface.setTitle("Jumjava");
  bg = loadImage(path + "/res/img/background.png");
  bg.resize(width, height);
  
  jump = new SoundFile(this, path + "/res/audio/jump.mp3");
  player = loadImage(path + "/res/img/cube.png");
  player.resize(subject.w, subject.h);
  
  platforms = generateLevel(10);
}


void draw() {
  background(#000000);
  image(bg, bgx, 0);
  image(bg, bgx+bg.width, 0);
  image(bg, bgx-bg.width, 0);
  
  if(subject.x <= 50){ // set to 400
    bgx = bgx + 3;
    subject.x = subject.x + 3;
    platforms.forEach((k, v) -> {
      Platform pf = (Platform)v;
      pf.x = pf.x + 3;
    });
  }
  
  if(subject.x >= 0){ // set to 800
    bgx = bgx - 3;
    subject.x = subject.x - 3;
    platforms.forEach((k, v) -> {
      Platform pf = (Platform)v;
      pf.x = pf.x - 3;
    });
  }
  
  if (bgx < -bg.width) {
    bgx = 0; // reset
  }
  
  if(bgx > bg.width){
    bgx = 0;
  }
  
  
  for(int i = 0; i < platforms.size(); i++){
    Platform p = (Platform) platforms.get("platform-"+ i);
    String colision = rectangleCollision(subject,p);
    
    if(colision != "none"){
        subject.collisionSide = colision;
    }
  }
  
  subject.update();
  subject.display();
  displayPositionData();
  
  for(int i = 0; i < platforms.size(); i++){
    pf = (Platform) platforms.get("platform-" + i);
    pf.display();
 }
}


void keyPressed() {
  switch (keyCode) {
    case 65: // key left
      left = true;
      break;
    case 68: // key right
      right = true;
      break;
    case 32: // key space
      space = true;
      break;
    case 114:
      debug = !debug;
      break;
   }
}


void keyReleased() {
  switch (keyCode) {
    case 65: // key left
      left = false;
      break;
    case 68: // key rightd
      right = false;
      break;
    case 32: // key space
      space = false;
      break;
  }
}


void displayPositionData() {
  if(debug){
    fill(0);
    String s = "\nvx: "+subject.vx+" vy: "+subject.vy;
    text(s, 10, 0);
  }
}


String rectangleCollision(Subject s, Platform p) {
  float dx = (s.x+s.halfWidth) - (p.x+p.halfWidth);
  float dy = (s.y+s.halfHeight) - (p.y+p.halfHeight);
  float combHalfWidths = s.halfWidth + p.halfWidth;
  float combHalfHeights = s.halfHeight + p.halfHeight;
  if (abs(dx) < combHalfWidths) {

    if (abs(dy) < combHalfHeights) {
      float overlapX = combHalfWidths - abs(dx);
      float overlapY = combHalfHeights - abs(dy);
      if (overlapX >= overlapY) {
        if (dy > 0) {
          s.y += overlapY;
          return "top";
        } else {
          s.y -= overlapY;
          return "bottom";
        }
      } else {
        if (dx > 0) {
          s.x += overlapX;
          return "left";
        } else {
          s.x -= overlapX;
          return "right";
        }
      }
    } else {
      return "none";
    }
  } else {
    return "none";
  }
}
