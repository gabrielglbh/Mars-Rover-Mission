import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/ui/widgets/mrm_icon_button.dart';
import 'package:marsmission/ui/widgets/mrm_button.dart';

class MapGenNavigationButtons extends StatelessWidget {
  final Function() onBack;
  final String forwardTitle;
  final Function() onForward;
  final bool showBackButton;
  final bool showTrailing;
  final Key? backKey;
  final Key? forwardKey;
  const MapGenNavigationButtons({
    Key? key,
    this.backKey,
    this.forwardKey,
    required this.onBack,
    required this.forwardTitle,
    required this.onForward,
    this.showBackButton = true,
    this.showTrailing = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: showBackButton,
          child: Expanded(
            child: MRMIconButton(key: backKey, onTap: onBack)
          ),
        ),
        Expanded(
          flex: showBackButton ? 4 : 1,
          child: MRMButton(
            key: forwardKey,
            title: forwardTitle,
            horizontal: Margins.margin8,
            trailing: showTrailing ? Icons.arrow_forward_rounded : null,
            onTap: onForward
          ),
        ),
      ],
    );
  }
}
