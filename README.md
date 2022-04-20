# Mars Rover Mission

The user will be able to input routes for the Rover to perform remotely in a generated 2D map.

## Input and Output

The user will place the Rover in an arbitrary 2D point, facing a certain direction, within a 2D map with N random obstacles. All these attributes will be selected by the user.

The user will command the Rover to move on the map through different sequential actions such as FRLLRFLLRRRL. The Rover will perform those actions in order and will result in 2 different outcomes:

- No obstacle found: the Rover completed the route perfectly without issues and the mission is completed.
- Obstacle found: the Rover encounter an obstacle and the route did not complete. The Rover will report the position of the obstacle and it will move to the last possible position (position when the obstacle was observed).

## Rover Actions

The Rover only understands 3 different actions: forward (F), right (R) or left (L).

This means that in order to go backwards, the Rover will have to perform two different actions.

## Rover Facing Directions

The Rover, as usual, will face 4 different directions: north (N), south (S), east (E) or west (W). 

The actions will have an impact depending on the direction the Rover is facing.
