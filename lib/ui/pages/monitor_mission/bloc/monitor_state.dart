part of 'monitor_bloc.dart';

abstract class MonitorState extends Equatable {
  const MonitorState();

  @override
  List<Object> get props => [];
}

class MonitorStateInitial extends MonitorState {}

class MonitorStateLoading extends MonitorState {}

class MonitorStateUpdateMap extends MonitorState {
  final List<List<MapTile>> map;
  final RoverDirection direction;
  final List<RoverAction> currentActions;

  const MonitorStateUpdateMap(this.map, this.direction, this.currentActions);

  @override
  List<Object> get props => [map, direction, currentActions];
}

class MonitorStateFinished extends MonitorState {
  final State finalState;

  const MonitorStateFinished(this.finalState);

  @override
  List<Object> get props => [finalState];
}
