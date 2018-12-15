class bird {
  PVector pos;
  float vel;
  float acc = 0.2;
  final int width = 51;
  final int height = 36;
  boolean dead;
  float dist = 0;
  int cPipe = 0;
  int score = 0;
  
  bird() {
    pos = new PVector(20, 250); // org 250
    vel = 0;
  }
  
  void draw() {
    translate(pos.x, pos.y);
    //rect(0, -18, 51, 36);
    image(sBird, 0, -18);
    translate(-pos.x, -pos.y);
  }
  
  void update() {
    if (!dead) {
      if (vel < 5) {
        vel += acc;
      }
      pos.y += vel;
    } else {
        pos.x -= pipeSpeed;
    }
  }
  
  void jump() {
   vel = -5; 
  }
  
   void calcScore() {
   if (!dead) {
     score += pipeSpeed;
     dist += pipeSpeed;
   
     if ((int)((dist-20) / brain.bRoom) > cPipe) {
      score += 10000;
      cPipe++;
     }
     
     /*println("\n");
     println("cPipe: " + cPipe);
     println("Pipes passed: " + (int)(dist / brain.bRoom));
     println("Score: " + score);
     println(pos.y);*/
   
   }
 }
}
