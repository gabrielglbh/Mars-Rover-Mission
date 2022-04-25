part of 'monitor_bloc.dart';

abstract class MonitorEvent extends Equatable {
  const MonitorEvent();

  @override
  List<Object> get props => [];
}

class MonitorEventIdle extends MonitorEvent {}

class MonitorEventStartSimulation extends MonitorEvent {
  final MapParams params;

  const MonitorEventStartSimulation(this.params);
}

class MonitorEventUpdateValues extends MonitorEvent {
  final MapParams params;
  final MapParams initialParams;
  final bool hasFinished;
  final bool isGeneratedMap;

  const MonitorEventUpdateValues({
    required this.params, required this.initialParams,
    required this.hasFinished, required this.isGeneratedMap
  });

  @override
  List<Object> get props => [params, initialParams, hasFinished, isGeneratedMap];
}