import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:marsmission/core/managers/theme_manager.dart';
import 'package:marsmission/core/types/modes.dart';
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
}
