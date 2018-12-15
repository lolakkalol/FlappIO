class background {
  int speed = 2;
  PVector pos;
  
  background(int x) {
   pos = new PVector(x, 0); 
  }
  
  void show() {
   image(sBackground, pos.x, 0);
  }
  
  void move() {
    pos.x -= speed;
  }
}
