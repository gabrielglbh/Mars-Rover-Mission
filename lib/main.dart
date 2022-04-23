import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:marsmission/core/managers/storage_manager.dart';
import 'package:marsmission/core/routing/pages.dart';
import 'package:marsmission/core/routing/routing.dart';
import 'package:marsmission/core/managers/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.getInstance();
  await EasyLocalization.ensureInitialized();
  runApp(const SetUpApp());
}

class SetUpApp extends StatelessWidget {
  const SetUpApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [
        Locale("en"),
        Locale("es")
      ],
      path: "lib/core/localization",
      fallbackLocale: const Locale("en"),
      child: const MarsRoverMission(),
    );
  }
}

class MarsRoverMission extends StatefulWidget {
  const MarsRoverMission({Key? key}) : super(key: key);

  @override
  State<MarsRoverMission> createState() => _MarsRoverMissionState();
}

class _MarsRoverMissionState extends State<MarsRoverMission> {
  @override
  void initState() {
    ThemeManager.instance.addListenerTo(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mars Rover Mission",
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.instance.currentLightThemeData,
      darkTheme: ThemeManager.instance.currentDarkThemeData,
      themeMode: ThemeManager.instance.themeMode,
      initialRoute: Pages.home,
      onGenerateRoute: onGenerateRoute,
    );
  }
}