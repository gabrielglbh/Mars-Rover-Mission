import 'package:marsmission/core/algorithm/algorithm.dart';
import 'package:marsmission/core/algorithm/model.dart';
import 'package:marsmission/core/algorithm/state.dart';
import 'package:marsmission/core/types/map_tiles.dart';
import 'package:marsmission/core/types/rover_actions.dart';
import 'package:marsmission/core/types/rover_directions.dart';
import 'package:test/test.dart';

void main() {
  final instance = Algorithm();

  group("Algorithm Run", () {
    group("Epoch", () {
      test("To be continued", () {
        final epochMap = [
          [MapTile.grass, MapTile.obstacle, MapTile.grass],
          [MapTile.grass, MapTile.grass, MapTile.rover],
          [MapTile.grass, MapTile.grass, MapTile.obstacle]];

        State state = State(1, 2, RoverDirection.E, false);
        MapParams params = MapParams(
            mapX: epochMap.length, mapY: epochMap[0].length, obstacles: 2,
            roverX: 1, roverY: 2, direction: RoverDirection.E,
            actions: [], map: epochMap
        );

        instance.performActionOnTestMap(params, epochMap, RoverAction.L, state, onContinue: (s) {
          state = s;
        });

        expect(state.encounteredObstacle, false);
      });

      test("Encountered Obstacle", () {
        final epochMap = [
          [MapTile.grass, MapTile.obstacle, MapTile.grass],
          [MapTile.grass, MapTile.grass, MapTile.rover],
          [MapTile.grass, MapTile.grass, MapTile.obstacle]];

        State state = State(1, 2, RoverDirection.E, false);
        MapParams params = MapParams(
            mapX: epochMap.length, mapY: epochMap[0].length, obstacles: 2,
            roverX: 1, roverY: 2, direction: RoverDirection.E,
            actions: [], map: epochMap
        );

        final result = instance.performActionOnTestMap(params, epochMap, RoverAction.F, state, onContinue: (s) {});

        expect((result as State).encounteredObstacle, true);
      });
    });

    group("Iterative", () {
      test("Completed", () {
        final map = [
          [MapTile.grass, MapTile.obstacle, MapTile.grass],
          [MapTile.rover, MapTile.grass, MapTile.grass],
          [MapTile.grass, MapTile.grass, MapTile.obstacle]];

        State state = State(1, 0, RoverDirection.E, false);
        const actions = [RoverAction.F, RoverAction.F, RoverAction.L];
        List<RoverAction> performed = [];

        MapParams params = MapParams(
            mapX: map.length, mapY: map[0].length, obstacles: 2,
            roverX: 1, roverY: 0, direction: RoverDirection.E,
            actions: actions, map: map
        );

        for (int a = 0; a < actions.length; a++) {
          final result = instance.performActionOnTestMap(params, map, actions[a], state, onContinue: (s) {
            state = s;
            performed.add(actions[a]);
          });
          params = result;
        }

        expect(state.encounteredObstacle, false);
        expect(performed.length, actions.length);
      });
    });

    test("Encountered Obstacle - Halt", () {
      final map = [
        [MapTile.grass, MapTile.obstacle, MapTile.grass],
        [MapTile.rover, MapTile.grass, MapTile.grass],
        [MapTile.grass, MapTile.grass, MapTile.obstacle]];

      State state = State(1, 0, RoverDirection.E, false);
      const actions = [RoverAction.F, RoverAction.F, RoverAction.R];
      List<RoverAction> performed = [];

      MapParams params = MapParams(
          mapX: map.length, mapY: map[0].length, obstacles: 2,
          roverX: 1, roverY: 0, direction: RoverDirection.E,
          actions: actions, map: map
      );

      for (int a = 0; a < actions.length; a++) {
        final result = instance.performActionOnTestMap(params, map, actions[a], state, onContinue: (s) {
          state = s;
          performed.add(actions[a]);
        });

        if (result is MapParams) {
          params = result;
        } else {
          state = result;
        }
      }

      expect(state.encounteredObstacle, true);
      expect(performed.length, actions.length - 1);
    });
  });
}