import 'package:easy_localization/easy_localization.dart';
import 'package:flag/flag.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/managers/storage_manager.dart';
import 'package:marsmission/core/managers/theme_manager.dart';
import 'package:marsmission/core/types/modes.dart';
import 'package:marsmission/main.dart';
import 'package:marsmission/ui/utils.dart';
import 'package:marsmission/ui/widgets/mrm_scaffold.dart';
import 'package:marsmission/ui/widgets/mrm_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ThemeMode _mode = ThemeMode.light;

  @override
  void initState() {
    _mode = ThemeManager.instance.themeMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MRMScaffold(
      title: "app_name".tr(),
      actions: [
        IconButton(
          key: Keys.themeMode,
          onPressed: () {
            _mode = ThemeManager.instance.themeMode;
            ThemeManager.instance.switchMode(_mode == ThemeMode.light);
          },
          icon: Icon(Theme.of(context).brightness == Brightness.light
              ? Icons.mode_night_rounded : Icons.light_mode_rounded),
        )
      ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: MRMText(
              text: "app_description".tr(),
              maxLines: 7
            )
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(Mode.values.length, (m) {
              return Mode.values[m].button(context);
            })
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.only(bottom: Margins.margin32),
            child: _languages(),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "attribution".tr(),
                  style: Theme.of(context).textTheme.bodyText1
                ),
                TextSpan(
                  text: "@gabrielglbh",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      decoration: TextDecoration.underline,
                      color: Colors.lightBlueAccent
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () async {
                    await Utils.instance.launchUrl(context, "https://github.com/gabrielglbh");
                  }
                )
              ]
            ),
          ),
        ],
      )
    );
  }

  Widget _languages() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          key: Keys.spanishFlag,
          child: Flag.fromCode(FlagsCode.ES, width: Sizes.flagSize, height: Sizes.flagSize),
          onTap: () {
            MarsRoverMission.setLocale(context, const Locale('es'));
            StorageManager.saveStringData(StorageManager.language, 'es');
          },
        ),
        GestureDetector(
          key: Keys.englishFlag,
          child: Flag.fromCode(FlagsCode.US, width: Sizes.flagSize, height: Sizes.flagSize),
          onTap: () {
            MarsRoverMission.setLocale(context, const Locale('en'));
            StorageManager.saveStringData(StorageManager.language, 'en');
          },
        ),
      ],
    );
  }
}
