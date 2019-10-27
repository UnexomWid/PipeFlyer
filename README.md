# About <a href="https://processing.org"><img align="right" src="https://img.shields.io/badge/Processing-3-0096D8?logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAALeSURBVDhPpZNdSFNhGMf/55x9uLnZ2qabup1tzgvLWlaoEVgiRJ/YKsPLbKJ9QHgR0W11FabopAi68SJCiC6EQEVRrDu9kM2sjNzaVFJxJsvPzenTe+YQxLrqD+8573ne5/d/znmf9+B/xaXuO4pEIvbllZWG0dGR8pm5+SKlQoBKleErLSkZ1Gi0XqNBH0ql7tXk5FTNs+aWRas9n8w5RhLzHZSRlUuCSkf2A0ep2fticWpquiaVvluBQLCm7tYd4uQq0hmNZDBnU7bVQU8bm6mppY0OHT9JglJD9XfvUTD4Y7dJOBy2NzY1J2FBzao5rWyeRmWnK6iemZ47f4kGP3wkndlO+00Wev7yFYUYk8IBn9/fXlx6jNT79KQ3ZZFSrSVOlkaCQk2yNC0dLHRRV28fyZi5FM+1OcnnH22XWJl0+TT22R0IzcBqy0QixuNIoQXV1dcxNDQMmVyOhw/u44anHulqOX7H1zE7Nw/f2LiboTd5ySAUDuhMOZng+TgSWwJG/KMIBoMoKS7G6zcd8NTdRltrE1QK1jaOgzxdh29fv+gkNmkQW1vFr/lZ9j4mKLV66LNFrMY32SqPeDwOv88PpUKBxcVlaAxGbK4vMWZZQrcNTFm5WFkVMDc9jcjPMGidLW5uAFsJVF9z493bDjx6/ARsh7GysMDiW3DYt/cwaeDIc3Tm5GQjuhCBSqsFaIuxG+AEGXp7+1BZeRnvewZYLAZOJoNOq4LDYe/cMRCtVu/5MxVgrWPuGzCbs+ByHYZNFGGxObBBPCuaAG0mkuZVVVchiqJ3x8Dlcg1evHC2taLsBGLs+7QaDcKTU+gf6EeuxQJ5mhKJtSXwcgUqyk/hitvdKjESu0s9Pd0tnloP6Q0GdurSieN54gSBNEYLmUQneWprqauruyWVntSen2l4eLh8fHy8IRAMuScmvrMIh/z8PDidzs6CggIva+3eyv9SNBotkkbq8S8C/gD+SyK2ulrljgAAAABJRU5ErkJggg==" alt="Processing 3" /></a>

PipeFlyer is an AI that learns to fly through obstacles by using Neural Networks and Genetic Algorithms.

![example](img/example.png)

# License <a href="https://github.com/UnexomWid/PipeFlyer/blob/master/LICENSE"><img align="right" src="https://img.shields.io/badge/License-MIT-blue.svg" alt="License: MIT" /></a>

PipeFlyer was created by [UnexomWid](https://uw.exom.dev). It is licensed under the [MIT](https://github.com/UnexomWid/PipeFlyer/blob/master/LICENSE) license.

# Releases

>Note: versions with the suffix **R** are considered stable releases, while those with the suffix **D** are considered unstable.

None.

# Note

This sketch was created for testing and experimenting purposes. There are better ways to accomplish what this sketch accomplishes.

# Running the sketch

The AI starts learning automatically. You can control the frame rate of the sketch by using the *W* and *S* keys. Holding down *W* speeds up the sketch (up to 960 fps), while 
holding down *S* slows down the sketch (down to 60 fps). The current frame rate, as well as the target frame rate, is displayed on the bottom-right.

# How it works

First, a population of randomly-initialized Neural Networks is created. Each member of the population is called a *player*, and decides every frame if it should jump or not.
Players that perform better have a higher score, and are more likely to be present in future generations. The best player will *always* be present in the next generation.

## Gene pool

After all players die, a new population is created from the gene pool of the current population. The number of times a player appears in the pool depends on its score.

>Example: if a player has a score of 500, it will appear 500 times in the gene pool.

## Crossover & Mutation

In order to create a member for the new generation, two random parents are chosen from the gene pool: network *A* and network *B*. The weights and biases of the child will be determined by the 
arithmetic mean between network *A* and network *B*. However, there's also random mutation (based on the mutation chance). After the child is created, it is added to the new population.

## New Generation 

After the new generation has been fully populated, the new players are tested and evolved just like those from the previous generation. This process repeats until a player successfully learns to fly
properly through the obstacles. At this point, the goal has been reached.

# Network Structure

>Note: This project does *not* use NEAT (NeuroEvolution of Augmenting Topologies). In other words, all networks have a fixed structure (number of neurons and layers) that does *not* evolve.

By default, each network has 4 layers:

* Input Layer: 6 neurons
* Hidden Layer 0: 16 neurons
* Hidden Layer 1: 16 neurons
* Output Layer: 2 neurons

All weights are between *-2* and *2*, while all biases are between *-5* and *5*.

The structure of the networks can be tweaked in any way (see `createNetwork()` and `getPlayerData()`, inside `PipeFlyer.pde`). These numbers have
been chosen arbitrarily.

## Activation Function

All layers use the same activation function for simplicity, a *fast sigmoid* function: `x/(1 + abs(x))`.