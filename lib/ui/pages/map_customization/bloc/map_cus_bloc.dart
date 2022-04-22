import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marsmission/core/algorithm/model.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/types/map_tiles.dart';
import 'package:marsmission/core/types/rover_actions.dart';
import 'package:marsmission/core/types/rover_directions.dart';

part 'map_cus_event.dart';
part 'map_cus_state.dart';

class MapCusBloc extends Bloc<MapCusEvent, MapCusState> {
  /// Shared between all page view
  late MapParams params;
  late MapTile selected;
  int page = 0;

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

    on<MapCusEventGoToPage>((event, emit) {
      emit(MapCusStateLoading());
      page = event.page;
      emit(MapCusStateUpdatedMap(params.map, params.direction, selected));
    });

    on<MapCusEventUpdateActions>((event, emit) {
      /// Deep copy of every parameter possible, as this is being copied
      /// everytime the user goes forwards or backwards
      params = params.copyRoute(actions: event.actions);
      final String err = params.validateTestParameters();
      if (err.isEmpty) {
        emit(MapCusStateMapFinished());
      } else {
        emit(MapCusStateFailure(err));
      }
    });
  }
}
