import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/ui/widgets/mrm_map_tile.dart';

class MRMMap extends StatelessWidget {
  /// List of tiles to generate the map with
  final List<MRMMapTile> list;
  final EdgeInsets margin;
  /// Size of the map and crossCount on the display GridView. Defaults to [Misc.exampleMapSize].
  final int mapSize;
  /// Whether the map should be wrapped in an Expanded Widget. Defaults to true.
  final bool isExpanded;
  /// Expanded flexible height within the caller boundaries. Defaults to 1.
  final int flex;
  const MRMMap({
    Key? key,
    required this.list,
    this.margin = const EdgeInsets.only(
        left: Margins.margin32, right: Margins.margin32,
        top: Margins.margin16
    ),
    this.mapSize = Misc.exampleMapSize,
    this.isExpanded = true,
    this.flex = 1
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isExpanded) return _map();
    return Expanded(flex: flex, child: _map());
  }

  Widget _map() {
    return  GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: mapSize
      ),
      shrinkWrap: true,
      padding: margin,
      physics: const NeverScrollableScrollPhysics(),
      //const ClampingScrollPhysics(),
      children: list
    );
  }
}
