import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/routing/pages.dart';
import 'package:marsmission/ui/widgets/mrm_button.dart';

enum Mode {
  test, generate
}

extension ModeExt on Mode {
  MRMButton button(BuildContext context) {
    switch (this) {
      case Mode.test:
        return MRMButton(
          key: Keys.staticMapButton,
          title: "generate_static_map_button_label".tr(),
          icon: Icons.grain_rounded,
          height: Sizes.mrmButtonDefaultHeight * 1.5,
          color: Colors.blue,
          onTap: () => Navigator.of(context).pushNamed(Pages.customization)
        );
      case Mode.generate:
        return MRMButton(
          key: Keys.randomMapButton,
          title: "generate_random_map_button_label".tr(),
          icon: Icons.build_rounded,
          height: Sizes.mrmButtonDefaultHeight,
          color: Colors.green,
          onTap: () => Navigator.of(context).pushNamed(Pages.generation)
        );
    }
  }
}