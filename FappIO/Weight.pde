class Weight {
  float weight;
  int start, end; // what neurons it's connected to
  
  Weight(int s, int e) {
    weight = random(-1, 1);
    start = s;
    end = e;
  }
}
