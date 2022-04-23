import 'package:flutter/cupertino.dart';
import 'package:marsmission/core/algorithm/model.dart';
import 'package:marsmission/core/routing/pages.dart';
import 'package:marsmission/ui/pages/home/home.dart';
import 'package:marsmission/ui/pages/map_customization/map_customization.dart';
import 'package:marsmission/ui/pages/map_generation/map_generation.dart';
import 'package:marsmission/ui/pages/monitor_mission/monitor_mission.dart';

/// Router generator in which all pages and their transitions are made.
Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Pages.home:
      return CupertinoPageRoute(builder: (_) => const HomePage());
    case Pages.monitor:
      final MapParams args = settings.arguments as MapParams;
      return CupertinoPageRoute(builder: (_) => MonitorMissionPage(
        params: args,
      ));
    case Pages.generation:
      return CupertinoPageRoute(builder: (_) => MapGenerationPage());
    case Pages.customization:
      return CupertinoPageRoute(builder: (_) => MapCustomization());
  }
  return null;
}