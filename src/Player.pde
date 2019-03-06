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
