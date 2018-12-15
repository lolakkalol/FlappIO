int[] gpopulation = new int[population];
Weight[][] opopulation = new Weight[population][]; // offspring population
int[] origOrder = new int[population];
float[] prob = new float[population];
Weight[][] parrents = new Weight[2][];
Weight[] offspring;
int[] matingpool = new int[100000];
int pointer;

void transferFitness() {
  for (int i = 0; i < population; i++) {
    gpopulation[i] = bird[i].score;
  }
  
  //println(gpopulation);
}

void newGen() {
  println("newGEN!");
  gpopulation = new int[population];
  opopulation = new Weight[population][];
  for (int i = 0; i < population; i++) {
    origOrder[i] = i;
  }
  
  parrents = new Weight[2][];
  transferFitness();
  bsort(gpopulation);
  calcProb(gpopulation);
  select();
  
  //opopulation[opopulation.length-1] = weights[origOrder[0]];
  
  for (int i = 0; i < opopulation.length; i++) {
    selectParrents();
    opopulation[i] = crossover();
  }
  
  weights = opopulation;
}

void mutation() {
  println("mutation!");
  for (int i = 0; i < 1; i++)
    offspring[(int)random(0, offspring.length)].weight = random(-1, 1);
}

Weight[] crossover() {
   offspring = new Weight[parrents[0].length];
   for (int i = 0; i<offspring.length; i++)
     offspring[i] = parrents[0][i];
   //offspring = parrents[0];
   
   for (int i = 0; i < parrents[0].length; i++) {
     float random = random(0, 1);
     if (random < 0.5)
       offspring[i] = parrents[1][i];       
   }
   //print2darray(offspring);
   
    if (random(0, 1) < 0.001) {
      mutation(); //<>//
    }
   
   return offspring;
}

void print2darray(Weight[] array) {
  for (Weight a : array)
    print(a.weight + "|");
}

void selectParrents() {
  parrents[0] = weights[matingpool[(int)random(0, pointer)]];
  parrents[1] = weights[matingpool[(int)random(0, pointer)]];
  
  if (parrents[0] == parrents[1])
    while (parrents[0] == parrents[1]) {
       parrents[1] = weights[matingpool[(int)random(0, pointer)]];
    }
}

void select() {
  pointer = 0;
  for (int i = 0; i < (int)(prob.length); i++) {
    int placeAmount = (int)(prob[i]*matingpool.length);
    //println((prob[i]*matingpool.length));
    if (placeAmount == 0) placeAmount = 1; // Deal with it
    for (int idx = 0; idx < placeAmount; idx++) {
      //println("pointer: " + pointer + " -  i: " + i);
       matingpool[pointer] = origOrder[i];
       if (pointer >= matingpool.length-1)
         break;
       
       pointer++;
    }
    if (pointer >= matingpool.length-1)
      break;
  }
}

void calcProb(int[] p) { // Funkar ish
float sum = 0;

for (int i = 0; i < (int)(gpopulation.length); i++)
  sum += (float)gpopulation[i];

  for (int i = 0; i < (int)(p.length); i++) {
    prob[i] = (float)gpopulation[i]/sum;  // org: prob[i] = (float)(bird[origOrder[i]].score/sum);
  }
}

int[] bsort(int[] p) { // Funkar nu och ska implementera det
  boolean swaped = true;
  while (swaped) {
    swaped = false;
    for (int i = 0; i < p.length-1; i++) {
      if (p[i] < p[i+1]) {
        p = swap(i, i+1, p);
        swaped = true;
      }
     }
     
     //println(gpopulation);
  }
  
  return p;
}

int[] swap(int first, int second, int[] p) {
  int tmp = p[first];
  p[first] = p[second];
  p[second] = tmp;
  
  tmp = origOrder[first];
  origOrder[first] = origOrder[second];
  origOrder[second] = tmp;
  
  return p;
}
