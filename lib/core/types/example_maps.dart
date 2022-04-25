import 'package:marsmission/core/types/map_tiles.dart';
import 'package:marsmission/ui/widgets/mrm_map_tile.dart';

enum ExampleType {
  park, obstacles, rover
}

extension ExampleTypeExt on ExampleType {
  List<MRMMapTile> get tiles {
    switch (this) {
      case ExampleType.park:
        return const [
          MRMMapTile(position: 1), MRMMapTile(position: 2), MRMMapTile(position: 3),
          MRMMapTile(position: 4), MRMMapTile(position: 5),
          MRMMapTile(position: 6), MRMMapTile(position: 7), MRMMapTile(position: 8),
          MRMMapTile(position: 9), MRMMapTile(position: 10),
          MRMMapTile(position: 11), MRMMapTile(position: 12), MRMMapTile(position: 13),
          MRMMapTile(position: 14), MRMMapTile(position: 15),
          MRMMapTile(position: 16), MRMMapTile(position: 17), MRMMapTile(position: 18),
          MRMMapTile(position: 19), MRMMapTile(position: 20),
          MRMMapTile(position: 21), MRMMapTile(position: 22), MRMMapTile(position: 23),
          MRMMapTile(position: 24), MRMMapTile(position: 25),
        ];
      case ExampleType.obstacles:
        return const [
          MRMMapTile(position: 1), MRMMapTile(position: 2), MRMMapTile(position: 3),
          MRMMapTile(position: 4, tile: MapTile.obstacle), MRMMapTile(position: 5),
          MRMMapTile(position: 6), MRMMapTile(position: 7), MRMMapTile(position: 8),
          MRMMapTile(position: 9, tile: MapTile.obstacle), MRMMapTile(position: 10),
          MRMMapTile(position: 11), MRMMapTile(position: 12), MRMMapTile(position: 13),
          MRMMapTile(position: 14, tile: MapTile.obstacle), MRMMapTile(position: 15),
          MRMMapTile(position: 16), MRMMapTile(position: 17, tile: MapTile.obstacle), MRMMapTile(position: 18),
          MRMMapTile(position: 19, tile: MapTile.obstacle), MRMMapTile(position: 20),
          MRMMapTile(position: 21, tile: MapTile.obstacle), MRMMapTile(position: 22, tile: MapTile.obstacle), MRMMapTile(position: 23),
          MRMMapTile(position: 24), MRMMapTile(position: 25),
        ];
      case ExampleType.rover:
        return const [
          MRMMapTile(position: 1), MRMMapTile(position: 2), MRMMapTile(position: 3),
          MRMMapTile(position: 4, tile: MapTile.obstacle), MRMMapTile(position: 5),
          MRMMapTile(position: 6), MRMMapTile(position: 7), MRMMapTile(position: 8),
          MRMMapTile(position: 9, tile: MapTile.obstacle), MRMMapTile(position: 10),
          MRMMapTile(position: 11), MRMMapTile(position: 12), MRMMapTile(position: 13),
          MRMMapTile(position: 14, tile: MapTile.obstacle), MRMMapTile(position: 15),
          MRMMapTile(position: 16), MRMMapTile(position: 17, tile: MapTile.obstacle), MRMMapTile(position: 18),
          MRMMapTile(position: 19, tile: MapTile.obstacle), MRMMapTile(position: 20),
          MRMMapTile(position: 21, tile: MapTile.obstacle), MRMMapTile(position: 22, tile: MapTile.obstacle), MRMMapTile(position: 23),
          MRMMapTile(position: 24), MRMMapTile(position: 25, tile: MapTile.rover),
        ];
    }
  }
}