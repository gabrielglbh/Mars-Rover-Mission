import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/types/map_tiles.dart';

class MRMMapTile extends StatelessWidget {
  final MapTile tile;
  const MRMMapTile({
    Key? key,
    this.tile = MapTile.grass
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 6,
      height: MediaQuery.of(context).size.width / 6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(RRadius.radius16),
        color: tile.color
      ),
      margin: const EdgeInsets.all(Margins.margin4),
      padding: const EdgeInsets.all(Margins.margin4),
      child: FittedBox(
        fit: BoxFit.contain,
        child: tile.icon,
      ),
    );
  }
}
