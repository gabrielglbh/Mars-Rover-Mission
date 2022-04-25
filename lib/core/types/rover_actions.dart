import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';

enum RoverAction {
  L, F, R
}

extension RoverActionExt on RoverAction {
  String get parsed {
    switch (this) {
      case RoverAction.F:
        return "rover_action_forward".tr();
      case RoverAction.R:
        return "rover_action_right".tr();
      case RoverAction.L:
        return "rover_action_left".tr();
    }
  }

  IconData get icon {
    switch (this) {
      case RoverAction.F:
        return Icons.arrow_upward_rounded;
      case RoverAction.R:
        return Icons.arrow_forward_rounded;
      case RoverAction.L:
        return Icons.arrow_back_rounded;
    }
  }

  Key get keys {
    switch (this) {
      case RoverAction.F:
        return Keys.roverActionF;
      case RoverAction.R:
        return Keys.roverActionR;
      case RoverAction.L:
        return Keys.roverActionL;
    }
  }
}