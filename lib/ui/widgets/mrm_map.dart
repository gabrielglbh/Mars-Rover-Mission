import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/ui/widgets/mrm_map_tile.dart';

class MRMMap extends StatelessWidget {
  final List<MRMMapTile> list;
  final double margin;
  final int mapSize;
  const MRMMap({
    Key? key,
    required this.list,
    this.margin = Margins.margin32,
    this.mapSize = Misc.exampleMapSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: mapSize
        ),
        shrinkWrap: true,
        padding: EdgeInsets.all(margin),
        physics: const NeverScrollableScrollPhysics(),
          //const ClampingScrollPhysics(),
        children: list
      ),
    );
  }
}
