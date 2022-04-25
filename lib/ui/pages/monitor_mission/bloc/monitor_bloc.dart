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

    on<MonitorEventUpdateValues>((event, emit) {
      MapParams p = event.params;
      final ip = event.initialParams;

      /// On retry, reset the rover position and direction and try again the algorithm
      if (event.hasFinished) {
        p = p.copyWithResetOnRover(p: p, ip: ip, randomizeObstacles: event.isGeneratedMap);
        emit(MonitorStateUpdatedParameters(p));
      } else {
        if (!algorithmHasBegan) {
          emit(MonitorStateUpdatedParameters(p));
        }
      }
    });

    on<MonitorEventStartSimulation>((event, emit) async {
      /// For the path, I have considered that the action to rotate the rover
      /// to the proper direction is neglectable and non relevant for the addition
      /// to the path, as the path will not be altered in any way without those
      /// sub-actions.
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
            emit(MonitorStateUpdateMap(p.map, p.direction, performedActions, path));
          } else if (res is State) {
            /// Finished and exit for loop
            _foundObstacle = true;
            algorithmHasBegan = false;
            emit(MonitorStateFinished(res, p.map, p.direction, performedActions, path));
          }
        });
      }
      /// Rover has successfully completed the mission
      if (!_foundObstacle) {
        algorithmHasBegan = false;
        emit(MonitorStateFinished(state, p.map, p.direction, performedActions, path));
      }
      /// Reset control variable
      _foundObstacle = false;
    });
  }
}
