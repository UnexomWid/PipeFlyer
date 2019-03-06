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
 
public class Neuron {
   
  public Neuron() {
    this.value = 0;
    this.activatedValue = 0;
    this.activated = false;
    this.bias = random(-5, 5);
  }
  
  public Neuron(int weightCount) {
    this.value = 0;
    this.activatedValue = 0;
    this.activated = false;
    this.bias = random(-5, 5);
    this.weights = new double[weightCount];
    
    for(int u = 0; u < weightCount; u++) {
     this.weights[u] = random(-2, 2); 
    }
  }
  
  public Neuron(double bias, double[] weights) {
    this.value = 0;
    this.activatedValue = 0;
    this.activated = false;
    this.bias = bias;
    this.weights = weights;
  }
  
  public double value;
  
  public double activatedValue;
  
  public boolean activated;
  
  public double bias;
  
  public double[] weights;
  
  public void receiveInput(double[] values) {
    this.value = 0;
    for(int u = 0; u < weights.length; u++) {
     this.value += weights[u] * values[u];
    }
    
    this.value += bias;
    
    this.activated = false;
  }
  
  public void activate() {
    if(!this.activated) {
      this.activated = true;
      this.activatedValue = this.value / (1 + Math.abs(this.value));
    }
  }
}
