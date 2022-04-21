import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/utils.dart';
import 'package:marsmission/ui/widgets/mrm_button.dart';
import 'package:marsmission/ui/widgets/mrm_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MRMScaffold(
      title: Text(
        "app_name".tr(),
        style: const TextStyle(
            fontWeight: FontWeight.bold
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "app_description".tr(),
              maxLines: 7,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
            )
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MRMButton(
                  title: "generate_random_map_button_label".tr(),
                  icon: Icons.grass_rounded,
                  color: Colors.green,
                  onTap: () {}
              ),
              MRMButton(
                  title: "generate_static_map_button_label".tr(),
                  icon: Icons.build_rounded,
                  color: Colors.blue,
                  onTap: () {}
              )
            ],
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.only(bottom: Margins.margin8),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "attribution".tr(),
                    style: Theme.of(context).textTheme.bodyMedium
                  ),
                  TextSpan(
                    text: "@gabrielglbh",
                    style: const TextStyle(
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
          ),
        ],
      )
    );
  }
}
