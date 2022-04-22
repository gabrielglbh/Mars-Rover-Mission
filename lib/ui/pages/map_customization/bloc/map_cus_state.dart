part of 'map_cus_bloc.dart';

abstract class MapCusState extends Equatable {
  const MapCusState();

  @override
  List<Object> get props => [];
}

class MapCusStateInitial extends MapCusState {}

class MapCusStateLoading extends MapCusState {}

class MapCusStateUpdatedMap extends MapCusState {
  final List<List<MapTile>> map;
  final RoverDirection dir;
  final MapTile selected;

  const MapCusStateUpdatedMap(this.map, this.dir, this.selected);
}
