import 'package:marsmission/core/algorithm/model.dart';
import 'package:marsmission/core/types/map_tiles.dart';
import 'package:marsmission/core/types/rover_actions.dart';
import 'package:marsmission/core/types/rover_directions.dart';
import 'package:test/test.dart';

void main() {
  group("Copy With Methods", () {
    test("Map Dimensions", () {
      const x = 2;
      const y = 2;
      const map = [[MapTile.grass, MapTile.grass], [MapTile.grass, MapTile.grass]];

      var p = MapParams();
      p = p.copyMapDimens(mapX: x, mapY: y);

      expect(p.mapX, x);
      expect(p.mapY, y);
      expect(p.map, map);
    });

    test("Number of Obstacles", () {
      const o = 1;
      final map = [[MapTile.grass]];
      const expectedMap = [[MapTile.obstacle]];

      var p = MapParams(mapX: map.length, mapY: map[0].length, map: map);
      p = p.copyObstacles(obstacles: o);

      expect(p.obstacles, o);
      expect(p.map, expectedMap);
    });

    test("Number of Obstacles without Map", () {
      const o = 1;

      var p = MapParams();
      p = p.copyObstacles(obstacles: o);

      expect(p.obstacles, null);
    });

    test("Rover Position", () {
      const x = 0;
      const y = 0;
      final map = [[MapTile.grass, MapTile.grass], [MapTile.grass, MapTile.grass]];
      const expectedMap = [[MapTile.rover, MapTile.grass], [MapTile.grass, MapTile.grass]];

      var p = MapParams(map: map);
      p = p.copyRoverPosition(roverX: x, roverY: y);

      expect(p.roverX, x);
      expect(p.roverY, y);
      expect(p.map, expectedMap);
    });

    test("Rover Position without Map", () {
      const x = 0;
      const y = 0;

      var p = MapParams();
      p = p.copyRoverPosition(roverX: x, roverY: y);

      expect(p.roverX, null);
      expect(p.roverY, null);
    });

    test("Rover Direction", () {
      const d = RoverDirection.N;

      var p = MapParams();
      p = p.copyRoverDirection(direction: d);

      expect(p.direction, d);
    });

    test("Rover Actions", () {
      const actions = [RoverAction.F, RoverAction.R];

      var p = MapParams();
      p = p.copyActions(actions: actions);

      expect(p.actions, actions);
    });
  });

  group("Validate All Parameters", () {
    test("Generated - All good", () {
      final MapParams params = MapParams(
          mapX: 3, mapY: 3, obstacles: 4,
          roverX: 0, roverY: 0,
          actions: [RoverAction.L],
          direction: RoverDirection.E,
          map: [
            [MapTile.grass, MapTile.obstacle, MapTile.grass],
            [MapTile.grass, MapTile.obstacle, MapTile.grass],
            [MapTile.grass, MapTile.obstacle, MapTile.obstacle]]
      );

      final results = params.validateGeneratedParameters();

      expect(results, true);
    });

    test("Test - All good", () {
      final MapParams params = MapParams(
          mapX: 3, mapY: 3, obstacles: 4,
          roverX: 0, roverY: 0,
          actions: [RoverAction.L],
          direction: RoverDirection.E,
          map: [
            [MapTile.grass, MapTile.obstacle, MapTile.grass],
            [MapTile.grass, MapTile.obstacle, MapTile.grass],
            [MapTile.grass, MapTile.obstacle, MapTile.obstacle]]
      );

      final results = params.validateTestParameters();

      expect(results, "");
    });

    test("Generated - Missing Map Dimensions", () {
      final MapParams params = MapParams(
          obstacles: 4,
          roverX: 0, roverY: 0,
          actions: [RoverAction.L],
          direction: RoverDirection.E,
          map: [
            [MapTile.grass, MapTile.obstacle, MapTile.grass],
            [MapTile.grass, MapTile.obstacle, MapTile.grass],
            [MapTile.grass, MapTile.obstacle, MapTile.obstacle]]
      );

      final result = params.validateGeneratedParameters();

      expect(result, false);
    });

    test("Generated - Missing obstacles", () {
      final MapParams params = MapParams(
          mapX: 3, mapY: 3,
          roverX: 0, roverY: 0,
          actions: [RoverAction.L],
          direction: RoverDirection.E,
          map: [
            [MapTile.grass, MapTile.obstacle, MapTile.grass],
            [MapTile.grass, MapTile.obstacle, MapTile.grass],
            [MapTile.grass, MapTile.obstacle, MapTile.obstacle]]
      );

      final result = params.validateGeneratedParameters();

      expect(result, false);
    });

    test("Generated - Missing rover initial position", () {
      final MapParams params = MapParams(
          mapX: 3, mapY: 3, obstacles: 4,
          actions: [RoverAction.L],
          direction: RoverDirection.E,
          map: [
            [MapTile.grass, MapTile.obstacle, MapTile.grass],
            [MapTile.grass, MapTile.obstacle, MapTile.grass],
            [MapTile.grass, MapTile.obstacle, MapTile.obstacle]]
      );

      final result = params.validateGeneratedParameters();

      expect(result, false);
    });

    test("Test - Missing rover initial position", () {
      final MapParams params = MapParams(
          mapX: 3, mapY: 3, obstacles: 4,
          actions: [RoverAction.L],
          direction: RoverDirection.E,
          map: [
            [MapTile.grass, MapTile.obstacle, MapTile.grass],
            [MapTile.grass, MapTile.obstacle, MapTile.grass],
            [MapTile.grass, MapTile.obstacle, MapTile.obstacle]]
      );

      final result = params.validateTestParameters();

      expect(result.isNotEmpty, true);
    });
  });
}