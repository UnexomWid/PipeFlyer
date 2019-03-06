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
