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
  RoverDirection? direction;
  List<RoverAction>? actions;
  List<List<MapTile>> map;

  MapParams({
    this.mapX,
    this.mapY,
    this.obstacles,
    this.roverX,
    this.roverY,
    this.direction,
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

  MapParams copyWith({
    int? mapX,
    int? mapY,
    int? obstacles,
    int? roverX,
    int? roverY,
    RoverDirection? direction,
    List<RoverAction>? actions
  }) => MapParams(
      mapX: mapX ?? this.mapX,
      mapY: mapY ?? this.mapY,
      obstacles: obstacles ?? this.obstacles,
      roverX: roverX ?? this.roverX,
      roverY: roverY ?? this.roverY,
      direction: direction ?? this.direction,
      actions: actions ?? this.actions,
      map: map
  );

  /// Validates that all the necessary fields for the algorithm to work
  /// If true, everything is fine
  bool validateParameters() {
    return mapX != null && mapY != null && obstacles != null &&
        roverX != null && roverY != null && direction != null &&
        actions != null;
  }
}