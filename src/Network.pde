/*
 * PipeFlyer - an AI that learns to fly through obstacles by using Neural Networks and Genetic Algorithms.
 * Copyright (C) 2019 UnexomWid

 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.

 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

public class Network {
   
  public Network() {
    
  }
  
  public Network(int layerCount) {
   this.layers = new Layer[layerCount]; 
  }
  
  public Network(Layer[] layers) {
   this.layers = layers; 
  }
  
  public Layer[] layers;
  
  public double[] predict(double[] inputLayer) {
    this.layers[0] = new Layer(inputLayer);
    
    for(int u = 0; u < this.layers.length - 1; u++) {
      this.layers[u].feedForward(this.layers[u+1]);
    }
    
    return this.layers[this.layers.length - 1].getOutput();
  }
  
  public Network crossover(Network b) {
    
    Network a = this;
    
    Layer[] layers = new Layer[a.layers.length];
    
    for(int u = 1; u < a.layers.length; u++) {
      Neuron[] neurons = new Neuron[a.layers[u].neurons.length];
      
      for(int l = 0; l < a.layers[u].neurons.length; l++) {
       double[] weights = new double[a.layers[u].neurons[l].weights.length];
       
       for(int k = 0; k < a.layers[u].neurons[l].weights.length; k++) {
         weights[k] = (a.layers[u].neurons[l].weights[k] + b.layers[u].neurons[l].weights[k])/2;
       }
       
       double bias = (a.layers[u].neurons[l].bias + b.layers[u].neurons[l].bias)/2;
       neurons[l] = new Neuron(bias, weights);
     }
     
     layers[u] = new Layer(neurons);
    }
    
    return new Network(layers);
  }
  
  public void mutate() {
    for(int u = 1; u < this.layers.length; u++) {
      for(int l = 0; l < this.layers[u].neurons.length; l++) {
        for(int k = 0; k < this.layers[u].neurons[l].weights.length; k++) {
          if(random(0, 1) < PipeFlyer.mutationChance)
            this.layers[u].neurons[l].weights[k] = random(-2, 2);
        }
        
        if(random(0, 1) < PipeFlyer.mutationChance) {
          this.layers[u].neurons[l].bias = random(-1, 1);
        }
      }
    }
  }
}
