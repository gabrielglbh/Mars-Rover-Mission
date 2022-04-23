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