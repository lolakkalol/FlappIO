class Weight {
  float weight;
  int start, end; //Vart den tar värdet ifrån och var den stoppar det manipulerade värdet.
  
  Weight(int s, int e) {
    weight = random(-1, 1);
    start = s;
    end = e;
  }
}
