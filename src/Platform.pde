class Platform{
  float w, h, x, y;
  String typeof;
  float halfWidth, halfHeight;
  
  Platform(float x, float y, float w, float h, String typ){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.typeof = typ;
    
    halfWidth = w / 2;
    halfHeight = h / 2;
  }
  
  void display(){
    fill(0, 0, 255); 
    rect(x, height - y, w, h);
  }
}
