import 'package:marsmission/core/types/map_tiles.dart';
import 'package:marsmission/core/types/rover_actions.dart';
import 'package:marsmission/core/types/rover_directions.dart';
import 'package:marsmission/ui/utils.dart';
import 'package:marsmission/ui/widgets/mrm_map_tile.dart';
import 'package:test/test.dart';

void main() {
  final utils = Utils.instance;

  group("Slice List", () {
    const replacement = "";

    test('List<String>', () {
      const list = ["F test", "R", "L test", "F", "R test", "L", "F", "R test", "L"];
      const pattern = " test";
      const expected = "F R L F R L F R L";

      final String result = utils.sliceWithout(list, pattern, replacement);

      expect(result, expected);
    });

    test('List<RoverAction>', () {
      var list = List.generate(8, (index) => RoverAction.values[0]);
      const pattern = "RoverAction.";
      const expected = "L L L L L L L L";

      final String result = utils.sliceWithout(list, pattern, replacement);

      expect(result, expected);
    });
  });

  group("Transform Matrix into List", () {
    const mat = [
      [MapTile.grass, MapTile.grass, MapTile.grass],
      [MapTile.grass, MapTile.obstacle, MapTile.grass],
      [MapTile.rover, MapTile.grass, MapTile.grass],
    ];

    test('transformIndexes', () {
      const x = 2;
      const y = 0;
      const expected = 6;

      final int result = utils.transformIndexes(mat.length, x, y);

      expect(result, expected);
    });

    test('generateMapFromMatrix', () {
      const List<MRMMapTile> expected = [
        MRMMapTile(tile: MapTile.grass, direction: RoverDirection.E, position: 1,),
        MRMMapTile(tile: MapTile.grass, direction: RoverDirection.E, position: 2,),
        MRMMapTile(tile: MapTile.grass, direction: RoverDirection.E, position: 3,),
        MRMMapTile(tile: MapTile.grass, direction: RoverDirection.E, position: 4,),
        MRMMapTile(tile: MapTile.obstacle, direction: RoverDirection.E, position: 5,),
        MRMMapTile(tile: MapTile.grass, direction: RoverDirection.E, position: 6,),
        MRMMapTile(tile: MapTile.rover, direction: RoverDirection.E, position: 7,),
        MRMMapTile(tile: MapTile.grass, direction: RoverDirection.E, position: 8,),
        MRMMapTile(tile: MapTile.grass, direction: RoverDirection.E, position: 9,),
      ];

      final result = utils.generateMapFromMatrix(mat);

      for (var t = 0; t < result.length; t++) {
        final isEqual = expected[t].equals(result[t]);
        expect(isEqual, true);
      }
    });
  });
}