import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:marsmission/core/algorithm/model.dart';
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
      /// Deep copy of every parameter possible, as this is being copied
      /// everytime the user goes forwards or backwards
      params = params.copyMapDimens(mapX: event.x, mapY: event.y);
      emit(GenMapStatePageChanged(event.page));
    });

    on<GenMapEventUpdateObstacles>((event, emit) {
      /// Deep copy of every parameter possible, as this is being copied
      /// everytime the user goes forwards or backwards
      params = params.copyObstacles(obstacles: event.obstacles);
      emit(GenMapStatePageChanged(event.page));
    });

    on<GenMapEventUpdateRoverPosition>((event, emit) {
      /// Deep copy of every parameter possible, as this is being copied
      /// everytime the user goes forwards or backwards
      params = params.copyRoverPosition(roverX: event.x, roverY: event.y);
      emit(GenMapStatePageChanged(event.page));
    });

    on<GenMapEventUpdateRoverDirection>((event, emit) {
      /// Deep copy of every parameter possible, as this is being copied
      /// everytime the user goes forwards or backwards
      params = params.copyRoverDirection(direction: event.direction);
      emit(GenMapStatePageChanged(event.page));
    });

    on<GenMapEventUpdateActions>((event, emit) {
      /// Deep copy of every parameter possible, as this is being copied
      /// everytime the user goes forwards or backwards
      params = params.copyActions(actions: event.actions);
      if (params.validateGeneratedParameters()) {
        emit(GenMapStateMapFinished());
      } else {
        emit(GenMapStateFailure("map_gen_error".tr()));
      }
    });
  }
}
