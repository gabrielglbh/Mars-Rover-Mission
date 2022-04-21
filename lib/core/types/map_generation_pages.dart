import 'package:easy_localization/easy_localization.dart';

enum MapGenPages {
  map, obs, rover, direction, actions
}

extension MapGenerationPagesExt on MapGenPages {
  String get name {
    switch (this) {
      case MapGenPages.map:
        return "map_gen_map_dimensions".tr();
      case MapGenPages.obs:
        return "map_gen_number_obstacles".tr();
      case MapGenPages.rover:
        return "map_gen_rover_dimensions".tr();
      case MapGenPages.direction:
        return "map_gen_rover_direction".tr();
      case MapGenPages.actions:
        return "map_gen_rover_actions".tr();
    }
  }

  String get description {
    switch (this) {
      case MapGenPages.map:
        return "map_gen_map_dimensions_description".tr();
      case MapGenPages.obs:
        return "map_gen_number_obstacles_description".tr();
      case MapGenPages.rover:
        return "map_gen_rover_dimensions_description".tr();
      case MapGenPages.direction:
        return "map_gen_rover_direction_description".tr();
      case MapGenPages.actions:
        return "map_gen_rover_actions_description".tr();
    }
  }
}