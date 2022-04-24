import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/types/map_tiles.dart';
import 'package:marsmission/core/types/rover_directions.dart';

class MRMMapTile extends StatefulWidget {
  final MapTile tile;
  /// Position in the grid to animate the tile in
  final int position;
  /// Expects the facing direction of the rover to be displayed in the map tile
  final RoverDirection? direction;
  final Function()? onTap;
  const MRMMapTile({
    Key? key,
    this.tile = MapTile.grass,
    this.position = 1,
    this.direction,
    this.onTap
  }) : super(key: key);

  @override
  State<MRMMapTile> createState() => _MRMMapTileState();

  /// Returns true if two instances of [MRMMapTile] are equal
  bool equals(MRMMapTile b) {
    return tile == b.tile && position == b.position && direction == b.direction;
  }
}

class _MRMMapTileState extends State<MRMMapTile> {
  double scale = 0;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() => scale = 1);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: Duration(milliseconds: 25 * widget.position),
      scale: scale,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: MediaQuery.of(context).size.width / 6,
          height: MediaQuery.of(context).size.width / 6,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(RRadius.radius16),
              color: widget.tile.color
          ),
          margin: const EdgeInsets.all(Margins.margin2),
          padding: EdgeInsets.all(
            widget.tile == MapTile.rover ? Margins.margin4 : Margins.margin8 + Margins.margin4
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: widget.tile.icon(direction: widget.direction),
          )
        ),
      ),
    );
  }
}
