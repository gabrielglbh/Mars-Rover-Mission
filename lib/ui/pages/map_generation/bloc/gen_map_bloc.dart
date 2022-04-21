import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marsmission/core/algorithm/model.dart';

part 'gen_map_event.dart';
part 'gen_map_state.dart';

class GenMapBloc extends Bloc<GenMapEvent, GenMapState> {
  /// Shared between all page view
  late MapParams params;

  GenMapBloc() : super(GenMapStateInitial()) {
    on<GenMapEventIdle>((event, emit) => params = MapParams());

    on<GenMapEventPageChanged>((event, emit) {
      /// Deep copy of every parameter possible, as this is being copied
      /// everytime the user goes forwards or backwards
      params = params.copyWith(
        mapX: event.params?.mapX,
        mapY: event.params?.mapY,
        obstacles: event.params?.obstacles,
        roverX: event.params?.roverX,
        roverY: event.params?.roverY,
        direction: event.params?.direction,
        actions: event.params?.actions
      );
      if (params.validateParameters()) {
        // TODO: Ready to make the rover go
      } else {
        emit(GenMapStatePageChanged(event.page));
      }
    });
  }
}
