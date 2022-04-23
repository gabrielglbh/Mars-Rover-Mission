import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/types/map_tiles.dart';
import 'package:marsmission/core/types/rover_directions.dart';
import 'package:marsmission/ui/pages/map_customization/bloc/map_cus_bloc.dart';
import 'package:marsmission/ui/widgets/mrm_map.dart';
import 'package:marsmission/ui/widgets/mrm_map_tile.dart';

class MRMInteractiveMap extends StatelessWidget {
  final MapCusBloc bloc;
  final List<MRMMapTile> map;
  final MapTile selected;
  final RoverDirection direction;
  const MRMInteractiveMap({
    Key? key,
    required this.bloc,
    required this.map,
    required this.selected,
    required this.direction
  }) : super(key: key);

  Widget _button(BuildContext context, MapTile tile) {
    return Expanded(
      child: Column(
        children: [
          AnimatedOpacity(
            opacity: selected == tile ? 1 : 0.4,
            duration: Animations.animation300,
            child: Padding(
              padding: const EdgeInsets.all(Margins.margin2),
              child: MRMMapTile(
                  tile: tile,
                  direction: direction,
                  onTap: () {
                    bloc.add(MapCusEventSetSelectedTile(tile));
                  }
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              tile.name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: MRMMap(
              list: map,
              isExpanded: false,
              margin: Margins.margin4,
              mapSize: Misc.testMapSize
            )
          ),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(MapTile.values.length, (index) {
              return _button(context, MapTile.values[index]);
            })
        ),
      ],
    );
  }
}
