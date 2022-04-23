import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/routing/pages.dart';
import 'package:marsmission/core/types/map_tiles.dart';
import 'package:marsmission/ui/widgets/mrm_button.dart';

enum Mode {
  generate, test
}

extension ModeExt on Mode {
  MRMButton button(BuildContext context) {
    switch (this) {
      case Mode.generate:
        return MRMButton(
          title: "generate_random_map_button_label".tr(),
          icon: MapTile.grass.icon().icon,
          height: Sizes.mrmButtonDefaultHeight,
          color: Colors.green,
          onTap: () => Navigator.of(context).pushNamed(Pages.generation)
        );
      case Mode.test:
        return MRMButton(
          title: "generate_static_map_button_label".tr(),
          icon: Icons.build_rounded,
          height: Sizes.mrmButtonDefaultHeight,
          color: Colors.blue,
          onTap: () => Navigator.of(context).pushNamed(Pages.customization)
        );
    }
  }
}