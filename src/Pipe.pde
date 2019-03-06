/*
 * NEAT_flyer - an AI that learns to fly through obstacles by using Neural Networks and NEAT.
 * Copyright (C) 2018-2019 UnexomWid

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
 
public class Pipe {
   
  public Pipe() {
    float pipeHeight = height - NEAT_flyer.pipeSpaceHeight;
    
    this.top = new Rectangle(new PVector(width * 1.5, 0), NEAT_flyer.pipeWidth, random(0.1, 0.9) * pipeHeight);
    this.bottom = new Rectangle(new PVector(width * 1.5, this.top.h + NEAT_flyer.pipeSpaceHeight), NEAT_flyer.pipeWidth, pipeHeight - this.top.h);
  }
  
  public Pipe(float offset) {
    float pipeHeight = height - NEAT_flyer.pipeSpaceHeight;
    
    this.top = new Rectangle(new PVector(offset, 0), NEAT_flyer.pipeWidth, random(0.1, 0.9) * pipeHeight);
    this.bottom = new Rectangle(new PVector(offset, this.top.h + NEAT_flyer.pipeSpaceHeight), NEAT_flyer.pipeWidth, pipeHeight - this.top.h);
  }
  
  public Rectangle top;
  
  public Rectangle bottom;
  
  public void update() {
   this.top.pos.x -= NEAT_flyer.pipeSpeed;
   this.bottom.pos.x -= NEAT_flyer.pipeSpeed;
  }
  
  public void show() {
   fill(255);
   this.top.show();
   this.bottom.show();
  }
  
  public boolean collidesWith(Rectangle rect) {
   return this.top.collidesWith(rect) || this.bottom.collidesWith(rect); 
  }
}
