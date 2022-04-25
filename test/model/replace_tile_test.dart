import 'package:marsmission/core/algorithm/model.dart';
import 'package:marsmission/core/types/map_tiles.dart';
import 'package:marsmission/core/types/rover_directions.dart';
import 'package:test/test.dart';

void main() {
  group("Replace Tile", () {
    group("Failures", () {
      test("Without Map", () {
        const x = 0;
        const y = 0;

        var p = MapParams();
        p = p.copyWithReplacedTile(x, y, MapTile.grass);

        expect(p.map, []);
      });

      test("Lower Out of Bounds Placement", () {
        const x = -1;
        const y = -1;
        final map = [
          [MapTile.grass, MapTile.grass],
          [MapTile.grass, MapTile.grass]];

        var p = MapParams(map: map, mapX: map.length, mapY: map[0].length);
        p = p.copyWithReplacedTile(x, y, MapTile.grass);

        expect(p.map, []);
      });

      test("Upper Out of Bounds Placement", () {
        const x = 3;
        const y = 3;
        final map = [
          [MapTile.grass, MapTile.grass],
          [MapTile.grass, MapTile.grass]];

        var p = MapParams(map: map, mapX: map.length, mapY: map[0].length);
        p = p.copyWithReplacedTile(x, y, MapTile.grass);

        expect(p.map, []);
      });
    });

    group("GRASS", () {
      const tile = MapTile.grass;
      const x = 0;
      const y = 0;

      test("For Obstacle", () {
        final map = [
          [MapTile.obstacle, MapTile.grass],
          [MapTile.grass, MapTile.grass]];
        var params = MapParams(map: map, obstacles: 1, mapX: map.length, mapY: map[0].length);

        params = params.copyWithReplacedTile(x, y, tile);

        expect(params.map[x][y], MapTile.grass);
        expect(params.obstacles, 0);
      });

      test("For Rover", () {
        final map = [
          [MapTile.rover, MapTile.grass],
          [MapTile.grass, MapTile.grass]];
        var params = MapParams(map: map, roverX: x, roverY: y, mapX: map.length, mapY: map[0].length);

        params = params.copyWithReplacedTile(x, y, tile);

        expect(params.map[x][y], MapTile.grass);
        expect(params.roverX, null);
        expect(params.roverY, null);
      });

      test("For Grass", () {
        final map = [
          [MapTile.grass, MapTile.grass],
          [MapTile.grass, MapTile.grass]];
        var params = MapParams(map: map, mapX: map.length, mapY: map[0].length);

        params = params.copyWithReplacedTile(x, y, tile);

        expect(params.map[x][y], MapTile.grass);
      });
    });

    group("OBSTACLE", () {
      const tile = MapTile.obstacle;
      const x = 0;
      const y = 0;

      test("For Obstacle", () {
        final map = [
          [MapTile.obstacle, MapTile.grass],
          [MapTile.grass, MapTile.grass]];
        var params = MapParams(map: map, obstacles: 1, mapX: map.length, mapY: map[0].length);

        params = params.copyWithReplacedTile(x, y, tile);

        expect(params.map[x][y], MapTile.obstacle);
        expect(params.obstacles, 1);
      });

      test("For Rover", () {
        final map = [
          [MapTile.rover, MapTile.grass],
          [MapTile.grass, MapTile.grass]];
        var params = MapParams(map: map, mapX: map.length, mapY: map[0].length);

        params = params.copyWithReplacedTile(x, y, tile);

        expect(params.map[x][y], MapTile.obstacle);
        expect(params.obstacles, 1);
        expect(params.roverX, null);
        expect(params.roverY, null);
      });

      test("For Grass", () {
        final map = [
          [MapTile.grass, MapTile.grass],
          [MapTile.grass, MapTile.grass]];
        var params = MapParams(map: map, mapX: map.length, mapY: map[0].length);

        params = params.copyWithReplacedTile(x, y, tile);

        expect(params.map[x][y], MapTile.obstacle);
        expect(params.obstacles, 1);
      });
    });

    group("ROVER", () {
      const tile = MapTile.rover;
      const x = 0;
      const y = 0;

      test("For Obstacle Without Rover", () {
        final map = [
          [MapTile.obstacle, MapTile.grass],
          [MapTile.grass, MapTile.grass]];
        var params = MapParams(map: map, obstacles: 1, mapX: map.length, mapY: map[0].length);

        params = params.copyWithReplacedTile(x, y, tile);

        expect(params.map[x][y], MapTile.rover);
        expect(params.obstacles, 0);
        expect(params.roverX, x);
        expect(params.roverY, y);
      });

      test("For Obstacle With Rover", () {
        final map = [
          [MapTile.obstacle, MapTile.grass],
          [MapTile.grass, MapTile.rover]];
        var params = MapParams(map: map, obstacles: 1, roverX: 1, roverY: 1,
            mapX: map.length, mapY: map[0].length);

        params = params.copyWithReplacedTile(x, y, tile);

        expect(params.map[x][y], MapTile.rover);
        expect(params.map[1][1], MapTile.grass);
        expect(params.obstacles, 0);
        expect(params.roverX, x);
        expect(params.roverY, y);
      });

      group("Rover Directions", () {
        test("For Rover North", () {
          final map = [
            [MapTile.rover, MapTile.grass],
            [MapTile.grass, MapTile.grass]];
          var params = MapParams(map: map, direction: RoverDirection.N,
              mapX: map.length, mapY: map[0].length);

          params = params.copyWithReplacedTile(x, y, tile);

          expect(params.map[x][y], MapTile.rover);
          expect(params.direction, RoverDirection.E);
        });

        test("For Rover East", () {
          final map = [
            [MapTile.rover, MapTile.grass],
            [MapTile.grass, MapTile.grass]];
          var params = MapParams(map: map, direction: RoverDirection.E,
              mapX: map.length, mapY: map[0].length);

          params = params.copyWithReplacedTile(x, y, tile);

          expect(params.map[x][y], MapTile.rover);
          expect(params.direction, RoverDirection.S);
        });

        test("For Rover South", () {
          final map = [
            [MapTile.rover, MapTile.grass],
            [MapTile.grass, MapTile.grass]];
          var params = MapParams(map: map, direction: RoverDirection.S,
              mapX: map.length, mapY: map[0].length);

          params = params.copyWithReplacedTile(x, y, tile);

          expect(params.map[x][y], MapTile.rover);
          expect(params.direction, RoverDirection.W);
        });

        test("For Rover West", () {
          final map = [
            [MapTile.rover, MapTile.grass],
            [MapTile.grass, MapTile.grass]];
          var params = MapParams(map: map, direction: RoverDirection.W,
              mapX: map.length, mapY: map[0].length);

          params = params.copyWithReplacedTile(x, y, tile);

          expect(params.map[x][y], MapTile.rover);
          expect(params.direction, RoverDirection.N);
        });
      });

      test("For Grass Without Rover", () {
        final map = [
          [MapTile.grass, MapTile.grass],
          [MapTile.grass, MapTile.grass]];
        var params = MapParams(map: map, mapX: map.length, mapY: map[0].length);

        params = params.copyWithReplacedTile(x, y, tile);

        expect(params.map[x][y], MapTile.rover);
        expect(params.roverX, x);
        expect(params.roverY, y);
      });

      test("For Grass With Rover", () {
        final map = [
          [MapTile.grass, MapTile.grass],
          [MapTile.grass, MapTile.rover]];
        var params = MapParams(map: map, roverX: 1, roverY: 1, mapX: map.length, mapY: map[0].length);

        params = params.copyWithReplacedTile(x, y, tile);

        expect(params.map[x][y], MapTile.rover);
        expect(params.map[1][1], MapTile.grass);
        expect(params.roverX, x);
        expect(params.roverY, y);
      });
    });
  });
}