import 'package:marsmission/core/algorithm/algorithm.dart';
import 'package:marsmission/core/algorithm/state.dart';
import 'package:marsmission/core/types/map_tiles.dart';
import 'package:marsmission/core/types/rover_actions.dart';
import 'package:marsmission/core/types/rover_directions.dart';
import 'package:test/test.dart';

void main() {
  final instance = Algorithm();

  group("SOUTH - Adjacent Tiles", () {
    const direction = RoverDirection.S;
    const F = RoverAction.F;
    const R = RoverAction.R;
    const L = RoverAction.L;

    group("FRONT", () {
      test("Passed", () {
        const map = [
          [MapTile.grass, MapTile.grass, MapTile.grass],
          [MapTile.rover, MapTile.grass, MapTile.grass],
          [MapTile.grass, MapTile.grass, MapTile.grass]];
        const x = 1;
        const y = 0;
        final expected = State(x+1, y, direction, false);

        final result = instance.checkAdjacentTiles(map, F, x, y, direction);

        expect(result.equals(expected), true);
      });

      test("Obstacle", () {
        const map = [
          [MapTile.grass, MapTile.grass, MapTile.grass],
          [MapTile.rover, MapTile.grass, MapTile.grass],
          [MapTile.obstacle, MapTile.grass, MapTile.grass]];
        const x = 1;
        const y = 0;
        final expected = State(x+1, y, direction, true);

        final result = instance.checkAdjacentTiles(map, F, x, y, direction);

        expect(result.equals(expected), true);
      });

      test("Out of bounds", () {
        const map = [
          [MapTile.grass, MapTile.grass, MapTile.grass],
          [MapTile.grass, MapTile.grass, MapTile.grass],
          [MapTile.rover, MapTile.grass, MapTile.grass]];
        const x = 2;
        const y = 0;
        final expected = State(x+1, y, direction, true);

        final result = instance.checkAdjacentTiles(map, F, x, y, direction);

        expect(result.equals(expected), true);
      });
    });

    group("RIGHT", () {
      test("Passed", () {
        const map = [
          [MapTile.grass, MapTile.grass, MapTile.grass],
          [MapTile.grass, MapTile.rover, MapTile.grass],
          [MapTile.grass, MapTile.grass, MapTile.grass]];
        const x = 1;
        const y = 1;
        final expected = State(x, y-1, RoverDirection.W, false);

        final result = instance.checkAdjacentTiles(map, R, x, y, direction);

        expect(result.equals(expected), true);
      });

      test("Obstacle", () {
        const map = [
          [MapTile.grass, MapTile.grass, MapTile.grass],
          [MapTile.obstacle, MapTile.rover, MapTile.grass],
          [MapTile.grass, MapTile.grass, MapTile.grass]];
        const x = 1;
        const y = 1;
        final expected = State(x, y-1, direction, true);

        final result = instance.checkAdjacentTiles(map, R, x, y, direction);

        expect(result.equals(expected), true);
      });

      test("Out of bounds", () {
        const map = [
          [MapTile.rover, MapTile.grass, MapTile.grass],
          [MapTile.grass, MapTile.grass, MapTile.grass],
          [MapTile.grass, MapTile.grass, MapTile.grass]];
        const x = 0;
        const y = 0;
        final expected = State(x, y-1, direction, true);

        final result = instance.checkAdjacentTiles(map, R, x, y, direction);

        expect(result.equals(expected), true);
      });
    });

    group("LEFT", () {
      test("Passed", () {
        const map = [
          [MapTile.grass, MapTile.grass, MapTile.grass],
          [MapTile.grass, MapTile.rover, MapTile.grass],
          [MapTile.grass, MapTile.grass, MapTile.grass]];
        const x = 1;
        const y = 1;
        final expected = State(x, y+1, RoverDirection.E, false);

        final result = instance.checkAdjacentTiles(map, L, x, y, direction);

        expect(result.equals(expected), true);
      });

      test("Obstacle", () {
        const map = [
          [MapTile.grass, MapTile.grass, MapTile.grass],
          [MapTile.grass, MapTile.rover, MapTile.obstacle],
          [MapTile.grass, MapTile.grass, MapTile.grass]];
        const x = 1;
        const y = 1;
        final expected = State(x, y+1, direction, true);

        final result = instance.checkAdjacentTiles(map, L, x, y, direction);

        expect(result.equals(expected), true);
      });

      test("Out of bounds", () {
        const map = [
          [MapTile.grass, MapTile.grass, MapTile.rover],
          [MapTile.grass, MapTile.grass, MapTile.grass],
          [MapTile.grass, MapTile.grass, MapTile.grass]];
        const x = 0;
        const y = 2;
        final expected = State(x, y+1, direction, true);

        final result = instance.checkAdjacentTiles(map, L, x, y, direction);

        expect(result.equals(expected), true);
      });
    });
  });
}