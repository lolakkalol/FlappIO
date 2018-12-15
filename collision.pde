void collision(bird bird, pipe pipe) {
 if (bird.pos.y < 5)
   bird.dead = true;
   
 if (bird.pos.y > height-5)
  bird.dead = true;
   
   if (bird.pos.x + bird.width > pipe.pos.x - pipe.width/2 && bird.pos.y + (bird.height/2) > pipe.pos.y + pipe.dis && pipe.pos.x + pipe.width/2 > bird.pos.x + bird.width) {
     bird.dead = true;
   }
   
   if (bird.pos.x > pipe.pos.x - pipe.width/2 && bird.pos.y + (bird.height/2) > pipe.pos.y + pipe.dis && pipe.pos.x + pipe.width/2 > bird.pos.x) {
     bird.dead = true;
   }
   
   if (bird.pos.x + bird.width > pipe.pos.x - pipe.width/2 && bird.pos.y - (bird.height/2) < pipe.pos.y - pipe.dis && pipe.pos.x + pipe.width/2 > bird.pos.x + bird.width) {
     bird.dead = true;
   }
   
   if (bird.pos.x > pipe.pos.x - pipe.width/2 && bird.pos.y - (bird.height/2) < pipe.pos.y - pipe.dis && pipe.pos.x + pipe.width/2 > bird.pos.x) {
     bird.dead = true;
   }  
}
