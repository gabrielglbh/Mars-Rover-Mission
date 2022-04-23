import 'package:marsmission/core/types/rover_directions.dart';

/// Defines the state for the route algorithm
class State {
  int x;
  int y;
  RoverDirection direction;
  bool encounteredObstacle;

  State(this.x, this.y, this.direction, this.encounteredObstacle);

  /*State copyWith({
    int? x,
    int? y,
    RoverDirection? facing,
    bool? hasFinished
  }) => State(
    x: x ?? this.x,
    y: y ?? this.y,
    facing: facing ?? this.facing,
    hasFinished: hasFinished ?? this.hasFinished
  );*/
}