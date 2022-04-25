import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';

enum RoverDirection {
  N, S, E, W
}

extension RoverDirectionExt on RoverDirection {
  IconData get roverIcon {
    switch (this) {
      case RoverDirection.N:
        return Icons.arrow_circle_up_outlined;
      case RoverDirection.S:
        return Icons.arrow_circle_down_outlined;
      case RoverDirection.E:
        return Icons.arrow_circle_right_outlined;
      case RoverDirection.W:
        return Icons.arrow_circle_left_outlined;
    }
  }

  String get parsed {
    switch (this) {
      case RoverDirection.N:
        return "N";
      case RoverDirection.S:
        return "S";
      case RoverDirection.E:
        return "E";
      case RoverDirection.W:
        return "W";
    }
  }

  Key get keys {
    switch (this) {
      case RoverDirection.N:
        return Keys.roverDirectionN;
      case RoverDirection.S:
        return Keys.roverDirectionS;
      case RoverDirection.E:
        return Keys.roverDirectionE;
      case RoverDirection.W:
        return Keys.roverDirectionW;
    }
  }
}