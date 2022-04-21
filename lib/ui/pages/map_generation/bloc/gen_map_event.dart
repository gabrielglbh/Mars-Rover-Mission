part of 'gen_map_bloc.dart';

abstract class GenMapEvent extends Equatable {
  const GenMapEvent();

  @override
  List<Object> get props => [];
}

class GenMapEventIdle extends GenMapEvent {}

class GenMapEventPageChanged extends GenMapEvent {
  final int page;

  const GenMapEventPageChanged(this.page);

  @override
  List<Object> get props => [page];
}

class GenMapEventSaveMapCoordinates extends GenMapEvent {
  final int x;
  final int y;

  const GenMapEventSaveMapCoordinates(this.x, this.y);

  @override
  List<Object> get props => [x, y];
}

class GenMapEventSaveNumberObstacles extends GenMapEvent {
  final int obstacles;

  const GenMapEventSaveNumberObstacles(this.obstacles);

  @override
  List<Object> get props => [obstacles];
}

class GenMapEventSaveRoverCoordinates extends GenMapEvent {
  final int x;
  final int y;

  const GenMapEventSaveRoverCoordinates(this.x, this.y);

  @override
  List<Object> get props => [x, y];
}

class GenMapEventSaveRoverDirection extends GenMapEvent {
  final RoverDirection direction;

  const GenMapEventSaveRoverDirection(this.direction);

  @override
  List<Object> get props => [direction];
}

class GenMapEventSaveRoverActions extends GenMapEvent {
  final List<RoverAction> actions;

  const GenMapEventSaveRoverActions(this.actions);

  @override
  List<Object> get props => [actions];
}
