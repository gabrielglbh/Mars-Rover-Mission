part of 'gen_map_bloc.dart';

abstract class GenMapEvent extends Equatable {
  const GenMapEvent();

  @override
  List<Object> get props => [];
}

class GenMapEventIdle extends GenMapEvent {}

class GenMapEventUpdateMap extends GenMapEvent {
  final int page;
  final int? x;
  final int? y;

  const GenMapEventUpdateMap(this.page, {this.x, this.y});

  @override
  List<Object> get props => [page];
}

class GenMapEventUpdateObstacles extends GenMapEvent {
  final int page;
  final int? obstacles;

  const GenMapEventUpdateObstacles(this.page, {this.obstacles});

  @override
  List<Object> get props => [page];
}

class GenMapEventUpdateRoverPosition extends GenMapEvent {
  final int page;
  final int? x;
  final int? y;

  const GenMapEventUpdateRoverPosition(this.page, {this.x, this.y});

  @override
  List<Object> get props => [page];
}

class GenMapEventUpdateRoverDirection extends GenMapEvent {
  final int page;
  final RoverDirection? direction;

  const GenMapEventUpdateRoverDirection(this.page, {this.direction});

  @override
  List<Object> get props => [page];
}

class GenMapEventUpdateActions extends GenMapEvent {
  final List<RoverAction>? actions;

  const GenMapEventUpdateActions({this.actions});
}
