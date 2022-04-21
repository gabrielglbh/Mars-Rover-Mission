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

  MapParams({
    this.mapX,
    this.mapY,
    this.obstacles,
    this.roverX,
    this.roverY,
    this.direction,
    this.actions
  });

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
    actions: actions ?? this.actions
  );

  bool validateParameters() {
    return mapX != null && mapY != null && obstacles != null &&
        roverX != null && roverY != null && direction != null &&
        actions != null;
  }
}