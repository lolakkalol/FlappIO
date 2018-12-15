class brain {
  pipe[] obs;
  int lastHeight;
  int bRoom;
  int x;
  
  void createObs() {
    lastHeight = 250;
    obs = new pipe[3];
    x = 400;
    bRoom = 400;
    
   for (int i = 0; i < 3; i++) {
     
    obs[i] = new pipe(x, lastHeight);
    
    int rand = (int)random(-200, 200);
    
    if (lastHeight+rand < 80)
      rand = (int)random(0, 100);
    else if (lastHeight+rand > 420)
      rand = (int)random(0, -100);
      
    lastHeight += rand;
    x += bRoom;
   }
  } // END of createObs
  
  void endOfLine(pipe p) {
    if (p.pos.x <= -5) {
      obs[0] = obs[1];
      obs[1] = obs[2];
      obs[2] = newPipe();
      pipesPassed++;
    }
  } // END of endOfLine
  
  pipe newPipe() {
    pipe p = new pipe((bRoom*3)-30, lastHeight);
    
    int rand = (int)random(-200, 200);
    
    if (lastHeight+rand < 80)
      rand = (int)random(0, 100);
    else if (lastHeight+rand > 420)
      rand = (int)random(0, -100);
      
    lastHeight += rand;
    
    return p;
  } // END of newPipe
  
  void backgroundUpdate() {
    if (b[0].pos.x <= -428) {
     b[0] = b[1];
     b[1] = b[2];
     b[2] = new background((int)(b[1].pos.x)+425);
    }
      
    
    for (background i : b) {
      i.show();
      i.move();
    }
  } // END of backgroundUpdate
}
