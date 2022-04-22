import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/ui/widgets/mrm_map_tile.dart';

class MRMMap extends StatelessWidget {
  final List<MRMMapTile> list;
  const MRMMap({
    Key? key,
    required this.list
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Misc.testMapSize
        ),
        shrinkWrap: true,
        padding: const EdgeInsets.all(Margins.margin32),
        physics: const NeverScrollableScrollPhysics(),
          //const ClampingScrollPhysics(),
        children: list
      ),
    );
  }
}
