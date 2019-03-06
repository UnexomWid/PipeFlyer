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

// General settings.
public static PVector flyForce = new PVector(0, -7);
public static PVector gravity = new PVector(0, 0.5);
public static float pipeWidth = 150;
public static float pipeSpaceHeight = 175;
public static float pipeSpeed = 5;

// Mutation chance and population size.
public static float mutationChance = 0.6;
public static int playerCount = 200;

// Helper stuff.
private static PImage playerImage;

private static ArrayList<Player> players;
private static ArrayList<Pipe> pipes;

private static Network[] nets;

private static int deadCount = 0;
private static int frame = 0;
private static int targetFrameRate = 60;

void setup() {
  size(800, 800, P2D);
  frameRate(60);
  
  
  // Load the player image.
  playerImage = loadImage("assets/player.png");
  
  initPlayers();
  
  initPipes();
  
  initNets();
}

void draw() {
  frame = (frame + 1) % 1000;
  
  // Speed up.
  if(keyPressed && (key == 'w' || key == 'W') && targetFrameRate <= 950) {
    targetFrameRate += 50;
    frameRate(targetFrameRate);
  }
  // Slow down.
  if(keyPressed && (key == 's' || key == 'S') && targetFrameRate > 109) {
    targetFrameRate -= 50;
    frameRate(targetFrameRate); 
  }
  
  background(0);
  
  // Update the pipes.
  if(deadCount < players.size()) {
    for(int u = 0; u < pipes.size(); u++) {
      pipes.get(u).update();
      pipes.get(u).show();
      // The players passed a pipe.
      if(pipes.get(u).top.pos.x == -pipes.get(u).top.w)
      {
        for(Player p : players) {
          if(!p.dead)
            p.score += 1000;
        }
        // Remove the last pipe and add a new one.
        pipes.remove(pipes.get(u));
        pipes.add(new Pipe(pipes.get(0).top.pos.x + (width * 1.5)));
        u--;
      }
    }
  }

  // Update all players.
  for(int u = 0; u < players.size(); u++) {
    Player player = players.get(u);
    Network net = nets[u];
    
    if(!player.dead) {
      player.applyForce(gravity);
      
      // Predict.
      double[] prediction = net.predict(getPlayerData(player, pipes.get(0)));
      if(prediction[0] < prediction[1])
        player.fly();
      
      player.update();
      
      player.score++;
      
      // The player died.
      if(collides(player) || pipes.get(0).collidesWith(player)) {
        player.dead = true;
        if(player.score < 1000)
          player.score = 1;
        else player.score -= 1000;
        ++deadCount;
        if(deadCount == players.size()) {
          newPopulation();
        }
      }
    }
    player.show();
  }

  drawStatus();
}

// Status.
void drawStatus() {
  fill(255, 0, 0);
  text("FPS: " + frameRate, width - 150, height - 10);
  text("Target FPS: " + targetFrameRate, width - 150, height - 30);
}

// Edge collision.
boolean collides(Player player) {
 if(player.pos.y < 0 || (player.pos.y + playerImage.height) > height)
   return true;
 return false;
}

// New random network.
Network createNetwork() {
 Layer inputLayer = new Layer(6, 0);
 Layer hiddenLayer1 = new Layer(16, 6);
 Layer hiddenLayer2 = new Layer(16, 16);
 Layer outputLayer = new Layer(2, 16);
 
 return new Network(new Layer[] { inputLayer, hiddenLayer1, hiddenLayer2, outputLayer });
}

/* 
 * Gets player data, which the Neural Network uses to predict the next action.
 * This could be done with fewer inputs, but it works for now.
 */
double[] getPlayerData(Player player, Pipe nearestPipe) {
 double[] data = new double[6];
 
 // The velocity of the player, relative to its Y position.
 data[0] = player.pos.y != 0 ? player.vel.y / player.pos.y : 0;
 // The position of the player, relative to the window height.
 data[1] = player.pos.y / height;
 // The player height (the player image decides the player height).
 data[2] = player.h;
 // The difference between the nearest pipe space's upper Y coordinate, and the player position, relative to the window height.
 data[3] = ((nearestPipe.top.pos.y + nearestPipe.top.h) / height) - (player.pos.y / height);
 // The difference between the nearest pipe space's lower Y coordinate, and the player position, relative to the window height.
 data[4] = ((nearestPipe.bottom.pos.y) / height) - (player.pos.y / height);
 // The distance between the nearest pipe and the player, on the X axis, relative to the window width.
 data[5] = ((nearestPipe.top.pos.x) / width) - (player.pos.x / width);
 
 return data;
}

void initPlayers() {
 players = new ArrayList<Player>();
  for(int u = 0; u < playerCount; u++) {
    players.add(new Player());
  } 
  deadCount = 0;
}

void initPipes() {
  pipes = new ArrayList<Pipe>();
  pipes.add(new Pipe());
  pipes.add(new Pipe(pipes.get(0).top.pos.x + (width * 1.5)));
}

void initNets() {
 nets = new Network[players.size()];
 
 for(int u = 0; u < nets.length; u++)
   nets[u] = createNetwork();
}

void newPopulation() {
 int totalScore = 0;
 int maxScore = 0;
 int maxScoreIndex = 0;
 for(int u = 0; u < players.size(); u++) {
   if(players.get(u).score > maxScore) {
    maxScore = players.get(u).score;
    maxScoreIndex = u;
   }
   totalScore += players.get(u).score;
 }
 
 int[] roulette = new int[totalScore];
 int index = 0;
 for(int u = 0; u < players.size(); u++) {
  for(int l = 0; l < players.get(u).score; l++) {
    roulette[index++] = u;
  }
 }
 
 Network[] newNets = new Network[nets.length];
 
 newNets[0] = nets[maxScoreIndex];
 
 for(int u = 1; u < players.size(); u++) {
   int parentA = roulette[floor(random(0, roulette.length))];
   int parentB = roulette[floor(random(0, roulette.length))];
   
   Network newNet = nets[parentA].crossover(nets[parentB]);
   if(random(0, 1) < mutationChance)
     newNet.mutate();
    
   newNets[u] = newNet;
 }
 
 nets = newNets;
 
 initPlayers();
 
 initPipes();
}
