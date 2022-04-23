import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marsmission/core/algorithm/algorithm.dart';
import 'package:marsmission/core/algorithm/model.dart';
import 'package:marsmission/core/algorithm/state.dart';
import 'package:marsmission/core/types/map_tiles.dart';
import 'package:marsmission/core/types/rover_actions.dart';
import 'package:marsmission/core/types/rover_directions.dart';

part 'monitor_event.dart';
part 'monitor_state.dart';

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  late Algorithm algorithm;
  /// Control variable for avoiding various instances of the algorithm running
  /// at the same time
  bool algorithmHasBegan = false;

  /// Control variable to allow the action loop to stop after the rover
  /// encountered an obstacle
  bool _foundObstacle = false;

  MonitorBloc() : super(MonitorStateInitial()) {
    on<MonitorEventIdle>((event, emit) => algorithm = Algorithm());

    on<MonitorEventStartSimulation>((event, emit) async {
      final List<State> path = [];
      final List<RoverAction> performedActions = [];
      algorithmHasBegan = true;
      MapParams p = event.params;

      /// Initial state
      var state = State(p.roverX ?? 0, p.roverY ?? 0, p.direction, false);
      path.add(state);

      /// Go through the list of actions
      for (int a = 0; a < event.params.actions.length; a++) {
        if (_foundObstacle) break;
        await Future.delayed(const Duration(milliseconds: 500), () {
          emit(MonitorStateLoading());
          final res = algorithm.performActionOnTestMap(
              p, p.map, p.actions[a], state,
              onContinue: (newState) {
                /// Update new state and add State to path
                state = newState;
                path.add(state);
              }
          );

          if (res is MapParams) {
            /// Upon continuation, update the params and notify UI
            p = res;
            performedActions.add(p.actions[a]);
            emit(MonitorStateUpdateMap(p.map, p.direction, performedActions));
          } else if (res is State) {
            /// Finished and exit for loop
            emit(MonitorStateFinished(res));
            _foundObstacle = true;
          }
        });
      }
    });
  }
}
