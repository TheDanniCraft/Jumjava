Subject subject;
Platform pf;

PImage bg;
int bgx = 0;

PImage turtlel, turtler;

boolean left, right, space;

void setup() {
  String path = dataPath("").replace("\\src\\data","");
  fullScreen();
  left = false;
  right = false;
  space = false;
  println(path);
  subject = new Subject();
  pf = new Platform(300, 460, 200, 25, "safe");
  surface.setTitle("Box Physic Simulation");

  bg = loadImage(path + "/res/img/spaceBG.jpg");
  turtlel = loadImage(path + "/res/img/turtleL.png");
  turtler = loadImage(path + "/res/img/turtleR.png");

  turtlel.resize(subject.w, subject.h);
  turtler.resize(subject.w, subject.h);
}

void draw() {
  background(#5eb7ff);

  image(bg, bgx, 0);
  image(bg, bgx+bg.width, 0);
  bgx--;

  if (bgx < -bg.width) {
    bgx = 0; // reset
  }

  subject.collisionSide = rectangleCollision(subject, pf);
  subject.update();
  subject.display();
  displayPositionData();
  pf.display();
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
  fill(0);
  String s = "\nvx: "+subject.vx+" vy: "+subject.vy + "\ncollisionSide: "+subject.collisionSide;
  text(s, 10, 0);
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
