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
