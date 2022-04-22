import 'dart:math';

import 'package:marsmission/core/types/map_tiles.dart';
import 'package:marsmission/core/types/rover_actions.dart';
import 'package:marsmission/core/types/rover_directions.dart';

/// Holds the object of parameters needed for the algorithm to work
class MapParams {
  int? mapX;
  int? mapY;
  int? obstacles;
  int? roverX;
  int? roverY;
  RoverDirection direction;
  List<RoverAction>? actions;
  List<List<MapTile>> map;

  MapParams({
    this.mapX,
    this.mapY,
    this.obstacles,
    this.roverX,
    this.roverY,
    this.direction = RoverDirection.E,
    this.actions,
    this.map = const []
  });

  _addObstacles(int? maxX, int? maxY) {
    int x = Random().nextInt(mapX ?? 0);
    int y = Random().nextInt(mapY ?? 0);
    /// If there is already an obstacle in the place, perform another placement
    if (map[x][y] == MapTile.obstacle) {
      _addObstacles(maxX, maxY);
    } else {
      map[x][y] = MapTile.obstacle;
    }
  }

  /// Generate the map with specified dimensions and updates the object
  MapParams copyMapDimens({
    int? mapX,
    int? mapY
  }) {
    map = List.generate(mapX ?? 0, (i) {
      return List.generate(mapY ?? 0, (j) {
        return MapTile.grass;
      });
    });
    return MapParams(
        mapX: mapX ?? this.mapX,
        mapY: mapY ?? this.mapY,
        obstacles: obstacles,
        roverX: roverX,
        roverY: roverY,
        direction: direction,
        actions: actions,
        map: map
    );
  }

  /// Randomly place obstacles in the map and updates the object
  MapParams copyObstacles({
    int? obstacles
  }) {
    for (var x = 0; x < (obstacles ?? 0); x++) {
      _addObstacles(mapX, mapY);
    }
    return MapParams(
        mapX: mapX,
        mapY: mapY,
        obstacles: obstacles ?? this.obstacles,
        roverX: roverX,
        roverY: roverY,
        direction: direction,
        actions: actions,
        map: map
    );
  }

  /// Place the rover, assurance there is no obstacle is done in the proper page
  /// and updated the object
  MapParams copyRoverPosition({
    int? roverX,
    int? roverY
  }) {
    map[(roverX ?? 0)][(roverY ?? 0)] = MapTile.rover;
    return MapParams(
        mapX: mapX,
        mapY: mapY,
        obstacles: obstacles,
        roverX: roverX ?? this.roverX,
        roverY: roverY ?? this.roverY,
        direction: direction,
        actions: actions,
        map: map
    );
  }

  /// Updates the object with the rover's direction
  MapParams copyRoverDirection({
    RoverDirection? direction
  }) {
    return MapParams(
        mapX: mapX,
        mapY: mapY,
        obstacles: obstacles,
        roverX: roverX,
        roverY: roverY,
        direction: direction ?? this.direction,
        actions: actions,
        map: map
    );
  }

  MapParams copyRoute({
    List<RoverAction>? actions
  }) {
    return MapParams(
        mapX: mapX,
        mapY: mapY,
        obstacles: obstacles,
        roverX: roverX,
        roverY: roverY,
        direction: direction,
        actions: actions ?? this.actions,
        map: map
    );
  }

  /// Gets a [tile] and place it in the map, updating it, depending on the
  /// [x] and [y] coordinates.
  MapParams copyWithReplacedTile(int x, int y, MapTile tile) {
    int _x = x;
    int _y = y;

    int _obs = obstacles ?? 0;
    RoverDirection _dir = direction;
    int? _rX = roverX;
    int? _rY = roverY;

    switch (tile) {
      case MapTile.grass:
        /// If there is the rover or an obstacle there, update coordinates to null
        /// or obstacles to correct number
        if (map[_x][_y] == MapTile.rover) {
          _rX = null;
          _rY = null;
        }
        if (map[_x][_y] == MapTile.obstacle) _obs -= 1;
        map[_x][_y] = MapTile.grass;
        break;
      case MapTile.obstacle:
        /// Adding the obstacle in any place
        _obs += 1;
        /// If there is the rover there, update coordinates to null
        if (map[_x][_y] == MapTile.rover) {
          _rX = null;
          _rY = null;
        }
        map[_x][_y] = MapTile.obstacle;
        break;
      case MapTile.rover:
        /// If there is a rover, change the direction of the rover
        if (map[_x][_y] == MapTile.rover) {
          switch (_dir) {
            case RoverDirection.N:
              _dir = RoverDirection.E;
              break;
            case RoverDirection.S:
              _dir = RoverDirection.W;
              break;
            case RoverDirection.E:
              _dir = RoverDirection.S;
              break;
            case RoverDirection.W:
              _dir = RoverDirection.N;
              break;
          }
        } else {
          /// Check if the map has a rover already. Then remove that rover by grass
          /// and place the rover in x and y.
          ///
          /// Add a label to stop the loop when finding the rover
          loop:
          for (int i = 0; i < map.length; i++) {
            for (int j = 0; j < map[i].length; j++) {
              if (map[i][j] == MapTile.rover) {
                map[i][j] = MapTile.grass;
                break loop;
              }
            }
          }
          /// If there is an obstacle, remove it and update params
          if (map[_x][_y] == MapTile.obstacle) _obs -= 1;
          map[_x][_y] = MapTile.rover;
          _rX = _x;
          _rY = _y;
        }
        break;
    }

    return MapParams(
        mapX: mapX,
        mapY: mapY,
        obstacles: _obs,
        roverX: _rX,
        roverY: _rY,
        direction: _dir,
        actions: actions,
        map: map
    );
  }

  /// Validates that all the necessary fields for the algorithm to work
  /// If true, everything is fine
  bool validateParameters() {
    return mapX != null && mapY != null && obstacles != null &&
        roverX != null && roverY != null && actions != null;
  }
}