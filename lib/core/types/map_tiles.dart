import 'dart:math';

import 'package:flutter/material.dart';

enum MapTile {
  grass, obstacle, rover
}

extension MapTileExt on MapTile {
  Icon get icon {
    switch (this) {
      case MapTile.grass:
        final icons = [Icons.grass_rounded, Icons.park_rounded];
        return Icon(icons[Random().nextInt(2)], color: Colors.white);
      case MapTile.obstacle:
        return const Icon(Icons.settings, color: Colors.white);
      case MapTile.rover:
        return const Icon(Icons.arrow_circle_right_rounded, color: Colors.white);
    }
  }

  Color get color {
    switch (this) {
      case MapTile.grass:
        return Colors.green;
      case MapTile.obstacle:
        return Colors.brown;
      case MapTile.rover:
        return Colors.grey;
    }
  }
}