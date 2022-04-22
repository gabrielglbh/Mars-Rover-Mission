part of 'map_cus_bloc.dart';

abstract class MapCusEvent extends Equatable {
  const MapCusEvent();

  @override
  List<Object> get props => [];
}

class MapCusEventInitial extends MapCusEvent {}

class MapCusEventGoToPage extends MapCusEvent {
  final int page;

  const MapCusEventGoToPage(this.page);
}

class MapCusEventSetTile extends MapCusEvent {
  final int x;
  final int y;
  final MapTile tile;

  const MapCusEventSetTile(this.x, this.y, this.tile);
}

class MapCusEventSetSelectedTile extends MapCusEvent {
  final MapTile tile;

  const MapCusEventSetSelectedTile(this.tile);
}

class MapCusEventUpdateActions extends MapCusEvent {
  final List<RoverAction>? actions;

  const MapCusEventUpdateActions({this.actions});
}
