import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/routing/pages.dart';
import 'package:marsmission/core/types/map_tiles.dart';
import 'package:marsmission/ui/widgets/mrm_button.dart';
import 'package:marsmission/ui/widgets/mrm_header.dart';
import 'package:marsmission/ui/widgets/mrm_map.dart';
import 'package:marsmission/ui/widgets/mrm_map_tile.dart';
import 'package:marsmission/ui/widgets/mrm_scaffold.dart';

class MapCustomization extends StatefulWidget {
  const MapCustomization({Key? key}) : super(key: key);

  @override
  State<MapCustomization> createState() => _MapCustomizationState();
}

class _MapCustomizationState extends State<MapCustomization> {
  MapTile _selectedTile = MapTile.obstacle;

  List<MRMMapTile> map = [];

  @override
  void initState() {
    /// TODO: WIP replace tapped tile with _selectedTile
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        map = List.generate(Misc.testMapSize * Misc.testMapSize, (i) {
          return MRMMapTile(
            tile: MapTile.grass,
            position: i+1,
            onTap: () {
              print(i);
              setState(() {
                map[i] = MRMMapTile(tile: _selectedTile);
              });
            },
          );
        });
      });
    });
    super.initState();
  }

  Widget _button(MapTile tile) {
    return AnimatedContainer(
      duration: Animations.animation300,
      padding: const EdgeInsets.all(Margins.margin2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RRadius.radius16),
          border: Border.all(width: 2, color: _selectedTile == tile
              ? Colors.black : Colors.white)
      ),
      child: MRMMapTile(
          tile: tile,
          onTap: () => setState(() => _selectedTile = tile)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MRMScaffold(
      title: "Customize Test Map",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MRMHeader(title: "Static Map",
              subtitle: "Tap and change tiles on this 5x5 map to test it. Select a tile from below and place it on the map."),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MRMMap(list: map),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(MapTile.values.length, (index) {
                    return _button(MapTile.values[index]);
                  })
                ),
                MRMButton(
                    title: "finished_map_button_label".tr(),
                    height: Sizes.mrmButtonDefaultHeight / 1.5,
                    horizontal: Margins.margin8,
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(Pages.monitor);
                    }
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
