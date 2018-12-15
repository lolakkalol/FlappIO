Weight weights[][];
Neuron neurons[];
int[] layerSize;
int inputSize = 3;
int hiddenSize;
int outputSize = 1;
int[] function; 

void setupNN(int population) {
   layerSize = new int[]{3, 6, 1}; // 3, 4, 1 Used to get the correct amouont of weights and to keep it more organized
   
  int zNeurons = 0;
  int zWeights = 0;
  for (int i = 0; i < layerSize.length; i++) {
     zNeurons += layerSize[i];
     if (i < layerSize.length-1)
      zWeights += (layerSize[i] * layerSize[i+1]);
  }
  
  function = new int[]{0, 0, 2};
  
  
  
  println("Weights: " + zWeights + " ; Neurons: " + zNeurons);
  
    weights = new Weight[population][zWeights];
    neurons = new Neuron[zNeurons];
}

void createNewNN() {
  
  int g = 0;
  int tot = layerSize[g];
    for (int o = 0; o < neurons.length; o++) { // Det var en fuling kanske hitta ett bättre sätt att göra det på?
      neurons[o] = new Neuron(function[g]);
      if (o+1 >= tot && g < layerSize.length-1) {
        g++; tot += layerSize[g];}
    }
  
  for (int layer = 0; layer < weights.length; layer++) {
    int counter = 0; // Used to count weights
    int eBefore = 0; // Offset used for the end vaiable in weight
    int sBefore = 0; // Offset used for the start variable in weight
        
    for(int focus = 0; focus < layerSize.length-1; focus++) { // Måste skapa offsets så att det blir korrekt
      
      eBefore = 0;
      for(int i = 0; i < focus; i++)
        eBefore += layerSize[i];
        
      sBefore = 0;
      for(int i = 0; i < focus+1; i++)
        sBefore += layerSize[i];
        
      //println("Focus: " + focus);
      for(int anchor = 0; anchor < layerSize[focus]; anchor++) {
        
        //println("Anchor: " + anchor);
        for(int target = 0; target < layerSize[focus+1]; target++) {
          
        //print("Target: " + target + " ; ");
        weights[layer][counter] = new Weight(anchor+eBefore, target+sBefore);
        //print(weights[layer][counter].weight + " ; ");
        counter++;
          
        }
        //println();
      }
      //println("-------------------------------");
    }
  }
}

void clearNeurons() {
   for (int i = 0; i < neurons.length; i++) {
     neurons[i].value = 0;
   }
}

float compute(float[] inputs, int ind) {
  for (int i = 0; i < layerSize[0]; i++) { // stoppar in "inputs" in i input neuronerna
    neurons[i].value = inputs[i];
  }
  
  int currentLimit = layerSize[0]*layerSize[1];
  int layerCounter = 0;
  int counter = 0;
  
  for (Weight w : weights[ind]) { // Kör igenom alla vikter och adderar värdet till respektive neuron
    //printOutNeurons();
    neurons[w.end].value += w.weight * neurons[w.start].value;
    if (counter >= currentLimit-1)
    {
      for (Neuron n : neurons) {
        //printOutNeurons();
        
        if (n.function != 0) {
          if (n.function == 1)
            n.value = relu(n.value);
            
          else if (n.function == 2)
            n.value = sigmoid(n.value);
        }
      }
      layerCounter++;
      //println(layerCounter);
      if (layerCounter < layerSize.length-1)
        currentLimit += layerSize[layerCounter]*layerSize[layerCounter+1];
    }
    counter++;
    //printOutNeurons();
  }
  //println(neurons[neurons.length-1].value);
  return neurons[neurons.length-1].value;
}

float relu(float value) {
   if (value < 0)
     return 0;
   else
     return value;
}

float sigmoid(float value) {
  if (value != 0)
    value = (1/(1+exp(-value)));
  return value;
}


void printOutNeurons() {
  int counter = 0; // Keeps track of the amount of neurons it has gone thourgh
  for (int i : layerSize) {
    for (int io = 0; io < i; io++) {
       output.print( " | " + neurons[counter].value + " | ");
       counter++;
    }
    output.println();
  }
  output.println();
  output.println("----------------------------------------------------------------------------------------");
}
