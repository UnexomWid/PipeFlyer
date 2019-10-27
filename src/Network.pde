/**
 * PipeFlyer (https://github.com/UnexomWid/PipeFlyer)
 *
 * This project is licensed under the MIT license.
 * Copyright (c) 2019 UnexomWid (https://uw.exom.dev)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
 * associated documentation files (the "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
 * following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial
 * portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
 * LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
