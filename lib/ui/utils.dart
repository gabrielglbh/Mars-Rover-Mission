import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/types/map_tiles.dart';
import 'package:marsmission/core/types/rover_directions.dart';
import 'package:marsmission/ui/widgets/mrm_map_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  Utils._();

  static final Utils _instance = Utils._();

  /// Singleton instance of [Utils]
  static Utils get instance => _instance;

  /// Creates a snack bar with the given [message]
  void createSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
          SnackBar(content: Row(
            children: [
              const Padding(padding: EdgeInsets.only(right: Margins.margin8), child: Icon(Icons.info_rounded)),
              Expanded(child: Text(message))
            ],
          ), duration: const Duration(seconds: 2))
      );
  }

  Future<void> launchUrl(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      createSnackBar(context, "Could not launch url.");
    }
  }

  /// Slice a [list] up with spaces between elements and replacing a certain
  /// [pattern] with a [replacement]
  String sliceWithout(List<dynamic> list, String pattern, String replacement) {
    return list.join(" ").replaceAll(pattern, replacement);
  }

  /// Transforms the x and y positions of a matrix into a index in a list
  int transformIndexes(int matLength, int x, int y) => x * matLength + y;

  /// Generates a list of [MRMMapTile] based of a matrix of [MapTile] for display purposes.
  ///
  /// The direction of the rover, [dir], can be declared along with an optional
  /// [onTap] method for listening to the tap on a certain tile on the caller.
  List<MRMMapTile> generateMapFromMatrix(List<List<MapTile>> m, {
    RoverDirection dir = RoverDirection.E, Function(int, int)? onTap
  }) {
    final List<MRMMapTile> map = [];

    for (int x = 0; x < m.length; x++) {
      for (int y = 0; y < m[x].length; y++) {
        final pos = transformIndexes(m.length, x, y);
        map.add(MRMMapTile(
          tile: m[x][y],
          direction: dir,
          position: pos + 1,
          onTap: () {
            if (onTap != null) onTap(x, y);
          },
        ));
      }
    }

    return map;
  }
}