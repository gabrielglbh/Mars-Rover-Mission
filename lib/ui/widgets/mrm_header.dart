import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/ui/widgets/mrm_text.dart';

class MRMHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const MRMHeader({
    Key? key,
    required this.title,
    required this.subtitle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MRMText(
            text: title,
            style: Theme.of(context).textTheme.headline5
        ),
        MRMText(
          padding: const EdgeInsets.only(top: Margins.margin8),
          text: subtitle
        ),
      ],
    );
  }
}
