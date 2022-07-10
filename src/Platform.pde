class Platform{
  float w, h, x, y;
  String typeof;
  float halfWidth, halfHeight;
  
  Platform(float x, float y, float w, float h, String typ){
    this.x = x;
    this.y = height - y;
    this.w = w;
    this.h = h;
    this.typeof = typ;
    
    halfWidth = w / 2;
    halfHeight = h / 2;
  }
  
  void display(){
    fill(31, 31, 31); 
    rect(x, y, w, h);
  }
}
