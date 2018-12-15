class pipe {
  PVector pos;
  static final int dis = 50; // org: 72
  final int width = 60;
  
  pipe(int x, int height) {
   pos = new PVector(x, height); 
  }
  
  void show() {
   //ellipse(pos.x, pos.y, 5, 5);
   translate(pos.x, pos.y);
   image(sPipe, -30, dis);
   rotate(PI);
   image(sPipe, -30, dis);
   rotate(PI);
   translate(-pos.x, -pos.y);
  }
  
  void move() {
    pos.x -= pipeSpeed; 
  }
}
