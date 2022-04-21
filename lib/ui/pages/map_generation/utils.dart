import 'package:marsmission/core/algorithm/model.dart';
import 'package:marsmission/core/types/map_generation_pages.dart';
import 'package:marsmission/core/types/map_tiles.dart';

class MapGenerationUtils {
  static List<int> validationDimens(MapParams p, String xS, String yS, MapGenPages type) {
    try {
      final x = int.parse(xS);
      final y = int.parse(yS);
      if (type == MapGenPages.map) {
        /// Default map must be 2x2
        if (x >= 2 && y >= 2) {
          return [x, y];
        } else {
          throw Exception();
        }
      } else if (type == MapGenPages.rover) {
        /// Must not be placed in a tile with an obstacle and within boundaries of the map
        if ((x < (p.mapX ?? 0) && x >= 0 && y < (p.mapY ?? 0) && y >= 0) &&
            (p.map[x][y] != MapTile.obstacle)) {
          return [x, y];
        } else {
          throw Exception();
        }
      } else {
        throw Exception();
      }
    } catch (err) {
      return [];
    }
  }

  static int validationObstacles(MapParams p, String xS) {
    /// Number of obstacles must be greater than 0
    /// Number of obstacles must leave space for AT LEAST the rover to be placed
    final max = ((p.mapX ?? 1) * (p.mapY ?? 1)) - 1;
    try {
      final x = int.parse(xS);
      if (x >= 0 && x <= max) {
        return x;
      } else {
        throw Exception();
      }
    } catch (err) {
      return -1;

    }
  }
}