import 'package:marsmission/core/algorithm/model.dart';
import 'package:marsmission/core/algorithm/state.dart';
import 'package:marsmission/core/types/map_tiles.dart';
import 'package:marsmission/core/types/rover_actions.dart';
import 'package:marsmission/core/types/rover_directions.dart';

class Algorithm {
  /// Performs the route on the TEST [map] with the defined [actions].
  ///
  /// The rover will begin on [roverPosX] x [roverPosY] in the map, facing
  /// [roverDirection] and will update based on the actions, updating its
  /// position and facing direction.
  ///
  /// Can return:
  ///
  /// 1. [State] when the rover encounter an obstacle, returning the coordinates
  /// where it was found.
  ///
  /// 2. [MapParams] when the rover continue its journey.
  dynamic performActionOnTestMap(
      MapParams p,
      List<List<MapTile>> map,
      RoverAction action,
      State state,
      { required Function(State) onContinue }
  ) {
    final newState = checkAdjacentTiles(map, action, state.x, state.y, state.direction);
    if (newState.encounteredObstacle) {
      return newState;
    } else {
      p = p.copyWithReplacedTile(state.x, state.y, MapTile.grass);
      p = p.copyWithReplacedTile(newState.x, newState.y, MapTile.rover);
      p = p.copyRoverDirection(direction: newState.direction);

      onContinue(newState);
      return p;
    }
  }

  /// Checks orthogonally adjacent tiles to move the rover to.
  /// If the rover is going to an obstacle or to the void (end of map),
  /// the execution is finished as the rover acknowledges its destiny.
  ///
  /// Else, the state of the rover is updated to the new position and facing
  /// direction.
  ///
  /// The movement is calculated relative to the facing of the rover.
  ///
  /// Return a new [State] to work with in the next iteration of [performActionsOnMap].
  ///
  /// NOTE: The x and y coordinates are swapped.
  State checkAdjacentTiles(
      List<List<MapTile>> map,
      RoverAction action,
      int x,
      int y,
      RoverDirection direction
  ) {
    final int maxX = map.length;
    final int maxY = map[0].length;

    switch (direction) {
      case RoverDirection.N:
        switch (action) {
          /// Move up
          case RoverAction.F:
            if (x-1 < 0 || map[x-1][y] == MapTile.obstacle) {
              return State(x-1, y, direction, true);
            } else {
              return State(x-1, y, direction, false);
            }
          /// Move right
          case RoverAction.R:
            if (y+1 >= maxY || map[x][y+1] == MapTile.obstacle) {
              return State(x, y+1, direction, true);
            } else {
              return State(x, y+1, RoverDirection.E, false);
            }
          /// Move left
          case RoverAction.L:
            if (y-1 < 0 || map[x][y-1] == MapTile.obstacle) {
              return State(x, y-1, direction, true);
            } else {
              return State(x, y-1, RoverDirection.W, false);
            }
        }
      case RoverDirection.S:
        switch (action) {
          /// Move down
          case RoverAction.F:
            if (x+1 >= maxX || map[x+1][y] == MapTile.obstacle) {
              return State(x+1, y, direction, true);
            } else {
              return State(x+1, y, direction, false);
            }
          /// Move left
          case RoverAction.R:
            if (y-1 < 0 || map[x][y-1] == MapTile.obstacle) {
              return State(x, y-1, direction, true);
            } else {
              return State(x, y-1, RoverDirection.W, false);
            }
          /// Move right
          case RoverAction.L:
            if (y+1 >= maxY || map[x][y+1] == MapTile.obstacle) {
              return State(x, y+1, direction, true);
            } else {
              return State(x, y+1, RoverDirection.E, false);
            }
        }
      case RoverDirection.E:
        switch (action) {
          /// Move right
          case RoverAction.F:
            if (y+1 >= maxY || map[x][y+1] == MapTile.obstacle) {
              return State(x, y+1, direction, true);
            } else {
              return State(x, y+1, direction, false);
            }
          /// Move down
          case RoverAction.R:
            if (x+1 >= maxX || map[x+1][y] == MapTile.obstacle) {
              return State(x+1, y, direction, true);
            } else {
              return State(x+1, y, RoverDirection.S, false);
            }
          /// Move up
          case RoverAction.L:
            if (x-1 < 0 || map[x-1][y] == MapTile.obstacle) {
              return State(x-1, y, direction, true);
            } else {
              return State(x-1, y, RoverDirection.N, false);
            }
        }
      case RoverDirection.W:
        switch (action) {
          /// Move left
          case RoverAction.F:
            if (y-1 < 0 || map[x][y-1] == MapTile.obstacle) {
              return State(x, y-1, direction, true);
            } else {
              return State(x, y-1, direction, false);
            }
          /// Move up
          case RoverAction.R:
            if (x-1 < 0 || map[x-1][y] == MapTile.obstacle) {
              return State(x-1, y, direction, true);
            } else {
              return State(x-1, y, RoverDirection.N, false);
            }
          /// Move down
          case RoverAction.L:
            if (x+1 >= maxX || map[x+1][y] == MapTile.obstacle) {
              return State(x+1, y, direction, true);
            } else {
              return State(x+1, y, RoverDirection.S, false);
            }
        }
    }
  }
}