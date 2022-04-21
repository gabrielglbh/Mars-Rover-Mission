import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:marsmission/core/routing/pages.dart';
import 'package:marsmission/core/routing/routing.dart';
import 'package:marsmission/ui/theme/light.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

class MarsRoverMission extends StatelessWidget {
  const MarsRoverMission({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "app_name".tr(),
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      theme: light,
      initialRoute: Pages.home,
      onGenerateRoute: onGenerateRoute,
    );
  }
}