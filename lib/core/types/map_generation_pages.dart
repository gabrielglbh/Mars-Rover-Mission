import 'package:easy_localization/easy_localization.dart';

enum MapGenerationPages {
  map, obs, rover, direction, actions
}

extension MapGenerationPagesExt on MapGenerationPages {
  String get name {
    switch (this) {
      case MapGenerationPages.map:
        return "map_gen_map_dimensions".tr();
      case MapGenerationPages.obs:
        return "map_gen_number_obstacles".tr();
      case MapGenerationPages.rover:
        return "map_gen_rover_dimensions".tr();
      case MapGenerationPages.direction:
        return "map_gen_rover_direction".tr();
      case MapGenerationPages.actions:
        return "map_gen_rover_actions".tr();
    }
  }
}