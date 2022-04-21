import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
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
          "map_gen_map_dimensions".tr(),
          style: Theme.of(context).textTheme.headline5
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: Margins.margin32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MRMInput(hint: "map_gen_hint_x_map".tr(), onEditingComplete: () {}),
                    MRMInput(hint: "map_gen_hint_y_map".tr(), onEditingComplete: () {})
                  ],
                ),
              ),
              Expanded(child: Container()),
              SizedBox(
                width: mapHeight,
                height: mapHeight,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 36,
                  itemBuilder: (context, index) {
                    return MRMMapTile(position: index);
                  },
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
