import 'package:flutter/material.dart';

enum RoverDirection {
  N, S, E, W
}

extension RoverDirectionExt on RoverDirection {
  IconData get roverIcon {
    switch (this) {
      case RoverDirection.N:
        return Icons.arrow_circle_up_rounded;
      case RoverDirection.S:
        return Icons.arrow_circle_down_rounded;
      case RoverDirection.E:
        return Icons.arrow_circle_right_rounded;
      case RoverDirection.W:
        return Icons.arrow_circle_left_rounded;
    }
  }
}