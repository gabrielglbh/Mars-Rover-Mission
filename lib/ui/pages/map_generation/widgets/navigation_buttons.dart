import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/ui/widgets/mrm_back_button.dart';
import 'package:marsmission/ui/widgets/mrm_button.dart';

class MapGenNavigationButtons extends StatelessWidget {
  final Function() onBack;
  final String forwardTitle;
  final Function() onForward;
  final bool showBackButton;
  const MapGenNavigationButtons({
    Key? key,
    required this.onBack,
    required this.forwardTitle,
    required this.onForward,
    this.showBackButton = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: showBackButton,
          child: Expanded(
            child: MRMBackButton(onBack: onBack)
          ),
        ),
        Expanded(
          flex: showBackButton ? 4 : 1,
          child: MRMButton(
            title: forwardTitle,
            horizontal: Margins.margin8,
            trailing: Icons.arrow_forward_rounded,
            onTap: onForward
          ),
        ),
      ],
    );
  }
}