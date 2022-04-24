import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:marsmission/core/types/rover_directions.dart';

enum MapTile {
  grass, obstacle, rover
}

extension MapTileExt on MapTile {
  Icon icon({RoverDirection? direction}) {
    switch (this) {
      case MapTile.grass:
        return const Icon(Icons.park_rounded, color: Colors.white);
      case MapTile.obstacle:
        return const Icon(Icons.waves_rounded, color: Colors.white);
      case MapTile.rover:
        return Icon(direction?.roverIcon ?? Icons.arrow_circle_right_outlined, color: Colors.white);
    }
  }

  Color get color {
    switch (this) {
      case MapTile.grass:
        return Colors.green;
      case MapTile.obstacle:
        return Colors.indigoAccent;
      case MapTile.rover:
        return Colors.pinkAccent;
    }
  }

  String get name {
    switch (this) {
      case MapTile.grass:
        return "map_tile_grass".tr();
      case MapTile.obstacle:
        return "map_tile_obstacle".tr();
      case MapTile.rover:
        return "map_tile_rover".tr();
    }
  }
}