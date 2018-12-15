int[] gpopulation = new int[population];
Weight[][] opopulation = new Weight[population][];
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
} // END of transferFitness

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
  
  for (int i = 0; i < opopulation.length; i++) {
    selectParrents();
    opopulation[i] = crossover();
  }
  
  weights = opopulation;
} // END of newGen

void mutation() {
  println("mutation!");
  for (int i = 0; i < 1; i++)
    offspring[(int)random(0, offspring.length)].weight = random(-1, 1);
} // END of mutation

Weight[] crossover() {
   offspring = new Weight[parrents[0].length];
   for (int i = 0; i<offspring.length; i++)
     offspring[i] = parrents[0][i];
   
   for (int i = 0; i < parrents[0].length; i++) {
     float random = random(0, 1);
     if (random < 0.5)
       offspring[i] = parrents[1][i];       
   }
   
    if (random(0, 1) < 0.001) {
      mutation();
    }
   
   return offspring;
} // END of crossover

void selectParrents() {
  parrents[0] = weights[matingpool[(int)random(0, pointer)]];
  parrents[1] = weights[matingpool[(int)random(0, pointer)]];
  
  if (parrents[0] == parrents[1])
    while (parrents[0] == parrents[1]) {
       parrents[1] = weights[matingpool[(int)random(0, pointer)]];
    }
} // END of selectParrents

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
} // END of select

void calcProb(int[] p) {
float sum = 0;

for (int i = 0; i < (int)(gpopulation.length); i++)
  sum += (float)gpopulation[i];

  for (int i = 0; i < (int)(p.length); i++) {
    prob[i] = (float)gpopulation[i]/sum;
  }
} // END of calcProb

int[] bsort(int[] p) {
  boolean swaped = true;
  while (swaped) {
    swaped = false;
    for (int i = 0; i < p.length-1; i++) {
      if (p[i] < p[i+1]) {
        p = swap(i, i+1, p);
        swaped = true;
      }
     }
  }
  
  return p;
} // END of bsort

int[] swap(int first, int second, int[] p) {
  int tmp = p[first];
  p[first] = p[second];
  p[second] = tmp;
  
  tmp = origOrder[first];
  origOrder[first] = origOrder[second];
  origOrder[second] = tmp;
  
  return p;
} // END of swap
