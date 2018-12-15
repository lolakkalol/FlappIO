static final int population = 1000;
PImage sBird;
PImage sPipe;
PImage sBackground;
PImage iBird;
int pipeSpeed;
brain brain = new brain();
bird bird[];
pipe p;
background b[];
PrintWriter output;
int pipesPassed = 0;
int generation = 1;

void setup() {
  iBird = loadImage("birdicon.png");
  changeAppIcon(iBird);
  changeAppTitle("FlappI/O");
  
  b = new background[3];
  b[0] = new background(0);
  b[1] = new background(425);
  b[2] = new background(851);
  
  setupNN(population);
  createNewNN();
  
  // Debugging & test area
  output = createWriter("positions.txt");
  
  //
  
  // --- Setup related ---
  size(500, 500);
  sBird = loadImage("bird.png");
  sPipe = loadImage("pipe.png");
  sBackground = loadImage("background.png");
  stroke(255, 0, 0);
  
  
  // --- Bird related ---
  pipeSpeed = 4;
  bird = new bird[population];
  
  for (int i = 0; i < bird.length; i++) {
    bird[i] = new bird();
  }
  
  // --- Obs related ---
  brain.createObs();
}

void draw() {
  background(color(255, 50, 50));
  
  brain.backgroundUpdate();
  
  // --- Bird related ---
  int nAlive = 0;
  for (int i = 0; i < bird.length; i++) {
    if (!bird[i].dead) {
      nAlive++;
      collision(bird[i], brain.obs[0]);
      bird[i].calcScore();

      float des = compute(new float[]{bird[i].pos.y, brain.obs[0].pos.y, brain.obs[0].pos.x}, i);
      clearNeurons();
      //println(des);
      //println(brain.obs[0].pos.x-bird[i].pos.x);
      //println(des);
      
      if(des > 0.5)
        bird[i].jump();
    }
    
    bird[i].update();
    bird[i].draw();
}

  if (nAlive <= 0) { // if true everyone is dead and it will restart the game and reproduce
    newGen();
    pipesPassed = 0;
    generation++;
    brain.createObs();
    for (int i = 0; i < bird.length; i++) {
      bird[i] = new bird();
    }
  }

  // --- Obs related ---
  brain.endOfLine(brain.obs[0]);
  for(pipe i : brain.obs) {
    i.show();
    i.move();
  }

fill(0);
textSize(32);
text("Birds alive: " + nAlive, 10, 30);
text("Pipes passed: " + pipesPassed, 10, 60);
text("Generation: " + generation, 10, 480);
  
}

void keyPressed() {
  //bird.jump();
}

void dispose() {
  output.flush();
  output.close();
}

void changeAppIcon(PImage img) {
  surface.setIcon(img);
}

void changeAppTitle(String title) {
  surface.setTitle(title);
}
