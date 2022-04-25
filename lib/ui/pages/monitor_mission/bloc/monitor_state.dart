part of 'monitor_bloc.dart';

abstract class MonitorState extends Equatable {
  const MonitorState();

  @override
  List<Object> get props => [];
}

class MonitorStateInitial extends MonitorState {}

class MonitorStateLoading extends MonitorState {}

class MonitorStateUpdatedParameters extends MonitorState {
  final MapParams params;

  const MonitorStateUpdatedParameters(this.params);

  @override
  List<Object> get props => [params];
}

class MonitorStateUpdateMap extends MonitorState {
  final List<List<MapTile>> map;
  final RoverDirection direction;
  final List<RoverAction> currentActions;
  final List<State> currentPath;

  const MonitorStateUpdateMap(this.map, this.direction, this.currentActions, this.currentPath);

  @override
  List<Object> get props => [map, direction, currentActions, currentPath];
}

class MonitorStateFinished extends MonitorState {
  final State finalState;
  final List<List<MapTile>> map;
  final RoverDirection direction;
  final List<RoverAction> currentActions;
  final List<State> currentPath;

  const MonitorStateFinished(this.finalState, this.map, this.direction,
      this.currentActions, this.currentPath);

  @override
  List<Object> get props => [finalState, map, direction, currentActions, currentPath];
}
