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
