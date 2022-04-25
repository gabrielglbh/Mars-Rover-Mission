import 'package:marsmission/core/algorithm/model.dart';
import 'package:marsmission/core/types/map_generation_pages.dart';
import 'package:marsmission/core/types/map_tiles.dart';
import 'package:marsmission/ui/pages/map_generation/utils.dart';
import 'package:test/test.dart';

void main() {
  group("Dimension Validation", () {
    final MapParams params = MapParams();
    final expectedError = [];

    test("Valid dimension", () {
      const dimX = "3";
      const dimY = "5";
      final expected = [int.parse(dimX), int.parse(dimY)];

      final result = MapGenerationUtils.validationDimens(params, dimX, dimY, MapGenPages.map);

      expect(result, expected);
    });

    test("Minimum dimension", () {
      const dimX = "2";
      const dimY = "2";
      final expected = [int.parse(dimX), int.parse(dimY)];

      final result = MapGenerationUtils.validationDimens(params, dimX, dimY, MapGenPages.map);

      expect(result, expected);
    });

    test("Negative dimension", () {
      const dimX = "-3";
      const dimY = "5";

      final result = MapGenerationUtils.validationDimens(params, dimX, dimY, MapGenPages.map);

      expect(result, expectedError);
    });

    test("Non int-parsable string dimension", () {
      const dimX = "hello";
      const dimY = "5";

      final result = MapGenerationUtils.validationDimens(params, dimX, dimY, MapGenPages.map);

      expect(result, expectedError);
    });
  });

  group("Obstacles Validation", () {
    final MapParams params = MapParams(mapX: 4, mapY: 4);
    const expectedError = -1;

    test("Valid number", () {
      const num = "8";
      final expected = int.parse(num);

      final result = MapGenerationUtils.validationObstacles(params, num);

      expect(result, expected);
    });

    test("Obstacles are exceeding map dimensions", () {
      const num = "465";

      final result = MapGenerationUtils.validationObstacles(params, num);

      expect(result, expectedError);
    });

    test("Maximum obstacles: X*Y - 1", () {
      const num = "15";
      final expected = int.parse(num);

      final result = MapGenerationUtils.validationObstacles(params, num);

      expect(result, expected);
    });

    test("Non int-parsable obstacles", () {
      const num = "hello";

      final result = MapGenerationUtils.validationObstacles(params, num);

      expect(result, expectedError);
    });
  });

  group("Rover Initial Position Validation", () {
    final MapParams params = MapParams(
      mapX: 3, mapY: 3, obstacles: 4,
      map: [
        [MapTile.grass, MapTile.obstacle, MapTile.grass],
        [MapTile.grass, MapTile.obstacle, MapTile.grass],
        [MapTile.grass, MapTile.obstacle, MapTile.obstacle]]
    );
    final expectedError = [];

    test("Valid position", () {
      const dimX = "0";
      const dimY = "0";
      final expected = [int.parse(dimX), int.parse(dimY)];

      final result = MapGenerationUtils.validationDimens(params, dimX, dimY, MapGenPages.rover);

      expect(result, expected);
    });

    test("Rover placed in obstacle", () {
      const dimX = "0";
      const dimY = "1";

      final result = MapGenerationUtils.validationDimens(params, dimX, dimY, MapGenPages.rover);

      expect(result, expectedError);
    });

    test("Lower out of bounds position", () {
      const dimX = "-3";
      const dimY = "5";

      final result = MapGenerationUtils.validationDimens(params, dimX, dimY, MapGenPages.rover);

      expect(result, expectedError);
    });

    test("Upper out of bounds position", () {
      const dimX = "56";
      const dimY = "9";

      final result = MapGenerationUtils.validationDimens(params, dimX, dimY, MapGenPages.rover);

      expect(result, expectedError);
    });

    test("Non int-parsable string dimension", () {
      const dimX = "hello";
      const dimY = "5";

      final result = MapGenerationUtils.validationDimens(params, dimX, dimY, MapGenPages.rover);

      expect(result, expectedError);
    });
  });
}