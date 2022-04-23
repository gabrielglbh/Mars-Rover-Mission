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
        return const Icon(Icons.air_rounded, color: Colors.white);
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
}