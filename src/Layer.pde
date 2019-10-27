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

public class Layer {
   
  public Layer() {
    
  }
  
  public Layer(int neuronCount, int weightCount) {
   this.neurons = new Neuron[neuronCount];
   
   for(int u = 0; u < neuronCount; u++) {
     this.neurons[u] = new Neuron(weightCount);
   }
  }
  
  public Layer(double[] neuronValues) {
    this.neurons = new Neuron[neuronValues.length];
    
    for(int u = 0; u < neuronValues.length; u++) {
      this.neurons[u] = new Neuron();
      this.neurons[u].activatedValue = neuronValues[u];
      this.neurons[u].activated = true;
    }
  }
  
  public Layer(Neuron[] neurons) {
   this.neurons = neurons; 
  }
  
  public Neuron[] neurons;
  
  public double[] getOutput() {
   double[] output = new double[this.neurons.length];
   
   for(int u = 0; u < output.length; u++) {
    output[u] = this.neurons[u].activatedValue; 
   }
   
   return output;
  }
  
  public void feedForward(Layer layer) {
    double[] output = this.getOutput();
    
    for(int u = 0; u < layer.neurons.length; u++) {
      layer.neurons[u].receiveInput(output);
      layer.neurons[u].activate();
    }
  }
}
