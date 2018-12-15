Weight weights[][];
Neuron neurons[];
int[] layerSize;
int inputSize = 3;
int hiddenSize;
int outputSize = 1;
int[] function; 

void setupNN(int population) {
   layerSize = new int[]{3, 6, 1}; // This is the size of the different layers so "layerSize = new int[]{3, 6, 1};" woud mean that there is 3 neurons in the first layer, 6 neurons on the second layer and 1 neuron on the third layer. !! This array needs to have the same length as function !!
   
  int zNeurons = 0;
  int zWeights = 0;
  for (int i = 0; i < layerSize.length; i++) {
     zNeurons += layerSize[i];
     if (i < layerSize.length-1)
      zWeights += (layerSize[i] * layerSize[i+1]);
  }
  
  function = new int[]{0, 0, 2}; // Says witch layer gets what function. !!This array needs to have the same length as layerSize!!
  
  
  
  println("Weights: " + zWeights + " ; Neurons: " + zNeurons);
  
    weights = new Weight[population][zWeights];
    neurons = new Neuron[zNeurons];
} // END of setupNN

void createNewNN() {
  
  int g = 0;
  int tot = layerSize[g];
    for (int o = 0; o < neurons.length; o++) {
      neurons[o] = new Neuron(function[g]);
      if (o+1 >= tot && g < layerSize.length-1) {
        g++; tot += layerSize[g];}
    }
  
  for (int layer = 0; layer < weights.length; layer++) {
    int counter = 0; // Used to count weights
    int eBefore = 0; // Offset used for the end vaiable in weight
    int sBefore = 0; // Offset used for the start variable in weight
        
    for(int focus = 0; focus < layerSize.length-1; focus++) {
      
      eBefore = 0;
      for(int i = 0; i < focus; i++)
        eBefore += layerSize[i];
        
      sBefore = 0;
      for(int i = 0; i < focus+1; i++)
        sBefore += layerSize[i];
        
      for(int anchor = 0; anchor < layerSize[focus]; anchor++) {
        
        for(int target = 0; target < layerSize[focus+1]; target++) {
          
        weights[layer][counter] = new Weight(anchor+eBefore, target+sBefore);
        counter++;
          
        }
      }
    }
  }
} // END of createNewNN

void clearNeurons() {
   for (int i = 0; i < neurons.length; i++) {
     neurons[i].value = 0;
   }
} // END of clearNeurons

float compute(float[] inputs, int ind) {
  for (int i = 0; i < layerSize[0]; i++) {
    neurons[i].value = inputs[i];
  }
  
  int currentLimit = layerSize[0]*layerSize[1];
  int layerCounter = 0;
  int counter = 0;
  
  for (Weight w : weights[ind]) {
    neurons[w.end].value += w.weight * neurons[w.start].value;
    if (counter >= currentLimit-1)
    {
      for (Neuron n : neurons) {
        
        if (n.function != 0) {
          if (n.function == 1)
            n.value = relu(n.value);
            
          else if (n.function == 2)
            n.value = sigmoid(n.value);
        }
      }
      layerCounter++;
      if (layerCounter < layerSize.length-1)
        currentLimit += layerSize[layerCounter]*layerSize[layerCounter+1];
    }
    counter++;
  }
  return neurons[neurons.length-1].value;
} // END of compute

float relu(float value) {
   if (value < 0)
     return 0;
   else
     return value;
} // END of relu

float sigmoid(float value) {
  if (value != 0)
    value = (1/(1+exp(-value)));
  return value;
} // END of sigmoid
