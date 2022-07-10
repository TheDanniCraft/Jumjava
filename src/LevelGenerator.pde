import java.util.Map;
import java.util.Random;

int x,y,w,h;
String s;


public Map generateLevel(int amount) { // type (1:easy, 2:medium, 3:hard, 0:endless)
  
  x = width/2 - 75;
  y = 300;
  w = 200;
  h = 25;
  
  Map level = new HashMap();
  for(int i = 0; i < amount; i++) {
    if (i == 0) {
      s = "start";
    } else if (i + 1 < amount) {
      s = "save";
    } else {
      s = "end";
    }
    level.put("platform-" + i, generatePlatform());
  }
  return level;
}


private Platform generatePlatform() {
  
  Platform platform = new Platform(x,y,w,h,s);
  
  x += w;
  int oldX = x;
  x += randomNumb(60, 300);
  
  int deltaX = x - oldX;
  int maxY = (int) (-0.003 * pow((deltaX - 40), 2) + 245);
  
  y = randomNumb(0, maxY)+300;
  w = randomNumb(50, 200);
  h = randomNumb(10, 100);
  if (y > h + 25) y -= h;
  
  s = "save";
  
  return platform;
}


public static int randomNumb(int min, int max) {
  
  if (min >= max) {
      throw new IllegalArgumentException("max must be greater than min");
    }
    
    Random r = new Random();
    return r.nextInt((max - min) + 1) + min;
}
