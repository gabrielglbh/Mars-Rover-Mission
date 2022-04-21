import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marsmission/core/types/rover_actions.dart';
import 'package:marsmission/core/types/rover_directions.dart';

part 'gen_map_event.dart';
part 'gen_map_state.dart';

class GenMapBloc extends Bloc<GenMapEvent, GenMapState> {
  GenMapBloc() : super(GenMapStateInitial()) {
    on<GenMapEventIdle>((event, emit) {});

    on<GenMapEventPageChanged>((event, emit) {
      emit(GenMapStatePageChanged(event.page));
    });

    on<GenMapEventSaveMapCoordinates>((event, emit) {});

    on<GenMapEventSaveNumberObstacles>((event, emit) {});

    on<GenMapEventSaveRoverCoordinates>((event, emit) {});

    on<GenMapEventSaveRoverDirection>((event, emit) {});

    on<GenMapEventSaveRoverActions>((event, emit) {});
  }
}
