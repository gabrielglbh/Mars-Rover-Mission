import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/ui/widgets/mrm_button.dart';
import 'package:marsmission/ui/widgets/mrm_input.dart';
import 'package:marsmission/ui/widgets/mrm_map_tile.dart';

class MapDimensionPage extends StatelessWidget {
  const MapDimensionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapHeight = MediaQuery.of(context).size.width - Sizes.mrmInputDefaultHeight;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Map Dimensions",
          style: Theme.of(context).textTheme.bodyText2
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: Margins.margin16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MRMInput(hint: "X: 6", onEditingComplete: () {}),
                    MRMInput(hint: "Y: 6", onEditingComplete: () {})
                  ],
                ),
              ),
              Expanded(child: Container()),
              SizedBox(
                width: mapHeight,
                height: mapHeight,
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: const [
                    MRMMapTile(), MRMMapTile(), MRMMapTile(), MRMMapTile(), MRMMapTile(), MRMMapTile(),
                    MRMMapTile(), MRMMapTile(), MRMMapTile(), MRMMapTile(), MRMMapTile(), MRMMapTile(),
                    MRMMapTile(), MRMMapTile(), MRMMapTile(), MRMMapTile(), MRMMapTile(), MRMMapTile(),
                    MRMMapTile(), MRMMapTile(), MRMMapTile(), MRMMapTile(), MRMMapTile(), MRMMapTile(),
                    MRMMapTile(), MRMMapTile(), MRMMapTile(), MRMMapTile(), MRMMapTile(), MRMMapTile(),
                    MRMMapTile(), MRMMapTile(), MRMMapTile(), MRMMapTile(), MRMMapTile(), MRMMapTile()
                  ],
                ),
              ),
              Expanded(child: Container())
            ],
          ),
        )
      ],
    );
  }
}
