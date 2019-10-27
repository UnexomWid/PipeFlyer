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
 
public class Player extends Rectangle {
   
  public Player() {
    super(new PVector(width / 10, height / 2), PipeFlyer.playerImage.width, PipeFlyer.playerImage.height);
    this.vel = new PVector(0, 0);
    this.acc = new PVector(0, 0);
    this.dead = false;
    this.score = 0;
  }
  
  public PVector vel;
  
  public PVector acc;
  
  public boolean dead;
  
  public int score;
  
  public void fly() {
    //this.vel.mult(0);
    this.vel.mult(0);
    this.applyForce(PipeFlyer.flyForce);
  }
  
  public void applyForce(PVector acc) {
   this.acc.add(acc);
  }
  
  public void update() {
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    /*if(this.pos.y < 0)
      this.pos.y = 0;
    if(this.pos.y + this.h > height)
      this.pos.y = height - this.h;*/
    this.acc.mult(0);
  }
  
  @Override
  public void show() {
    if(!this.dead) {
       beginShape();
       texture(PipeFlyer.playerImage);
       vertex(this.pos.x, this.pos.y, 0, 0);
       vertex(this.pos.x + this.w, this.pos.y, this.w, 0);
       vertex(this.pos.x + this.w, this.pos.y + this.h, this.w, this.h);
       vertex(this.pos.x, this.pos.y + this.h, 0, this.h);
       endShape();
    }
  }
}
