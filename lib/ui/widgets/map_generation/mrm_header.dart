import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';

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
        Text(
            title,
            style: Theme.of(context).textTheme.headline5
        ),
        Padding(
          padding: const EdgeInsets.only(top: Margins.margin8),
          child: Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyText1
          ),
        ),
      ],
    );
  }
}
