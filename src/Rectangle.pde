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
 
public class Rectangle {
   
  public Rectangle() {
    this.pos = new PVector();
    this.w = 0;
    this.h = 0;
  }
  
  public Rectangle(PVector pos, float w, float h) {
    this.pos = pos;
    this.w = w;
    this.h = h;
  }
  
  public PVector pos;
  
  public float w;
  
  public float h;
  
  public void show() {
    rect(this.pos.x, this.pos.y, this.w, this.h);
  }
  
  public boolean collidesWith(Rectangle rect) {
   return (this.pos.x + this.w >= rect.pos.x && this.pos.x <= rect.pos.x + rect.w && this.pos.y + this.h >= rect.pos.y && this.pos.y <= rect.pos.y + rect.h); 
  }
}
