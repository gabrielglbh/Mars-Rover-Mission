import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:marsmission/core/algorithm/model.dart';
import 'package:marsmission/core/types/map_generation_pages.dart';
import 'package:marsmission/core/types/rover_actions.dart';
import 'package:marsmission/core/types/rover_directions.dart';

part 'gen_map_event.dart';
part 'gen_map_state.dart';

class GenMapBloc extends Bloc<GenMapEvent, GenMapState> {
  /// Shared between all page view
  late MapParams params;

  GenMapBloc() : super(GenMapStateInitial()) {
    on<GenMapEventIdle>((event, emit) => params = MapParams());

    on<GenMapEventUpdateMap>((event, emit) {
      params = params.copyMapDimens(mapX: event.x, mapY: event.y);
      emit(GenMapStatePageChanged(event.page));
    });

    on<GenMapEventUpdateObstacles>((event, emit) {
      params = params.copyObstacles(obstacles: event.obstacles);
      emit(GenMapStatePageChanged(event.page));
    });

    on<GenMapEventUpdateRoverPosition>((event, emit) {
      params = params.copyRoverPosition(roverX: event.x, roverY: event.y);
      emit(GenMapStatePageChanged(event.page));
    });

    on<GenMapEventUpdateRoverDirection>((event, emit) {
      params = params.copyRoverDirection(direction: event.direction);
      emit(GenMapStatePageChanged(event.page));
    });

    on<GenMapEventUpdateActions>((event, emit) {
      params = params.copyActions(actions: event.actions);
      if (params.validateGeneratedParameters()) {
        emit(GenMapStateMapFinished(params));
        /// Revert back to the state where the map is shown on the latest state
        /// in case the user goes back and want to change things
        emit(GenMapStatePageChanged(MapGenPages.actions.index));
      } else {
        emit(GenMapStateFailure("map_gen_error".tr()));
        /// Revert back to the state where the map is shown on the latest state
        /// in case the user goes back and want to change things
        emit(GenMapStatePageChanged(MapGenPages.actions.index));
      }
    });
  }
}
