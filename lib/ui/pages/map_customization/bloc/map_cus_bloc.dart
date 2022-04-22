import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marsmission/core/algorithm/model.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/types/map_tiles.dart';
import 'package:marsmission/core/types/rover_directions.dart';

part 'map_cus_event.dart';
part 'map_cus_state.dart';

class MapCusBloc extends Bloc<MapCusEvent, MapCusState> {
  /// Shared between all page view
  late MapParams params;
  late MapTile selected;

  MapCusBloc() : super(MapCusStateInitial()) {
    on<MapCusEventInitial>((event, emit) {
      params = MapParams();
      selected = MapTile.obstacle;
      params = params.copyMapDimens(mapX: Misc.testMapSize, mapY: Misc.testMapSize);
      emit(MapCusStateUpdatedMap(params.map, params.direction, selected));
    });

    on<MapCusEventSetTile>((event, emit) {
      emit(MapCusStateLoading());
      params = params.copyWithReplacedTile(event.x, event.y, event.tile);
      emit(MapCusStateUpdatedMap(params.map, params.direction, selected));
    });

    on<MapCusEventSetSelectedTile>((event, emit) {
      emit(MapCusStateLoading());
      selected = event.tile;
      emit(MapCusStateUpdatedMap(params.map, params.direction, selected));
    });
  }
}
