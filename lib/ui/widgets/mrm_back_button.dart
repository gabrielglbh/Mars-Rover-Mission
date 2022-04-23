import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';

class MRMBackButton extends StatelessWidget {
  /// Width of the button
  final double? width;
  /// Height of the button
  final double? height;
  /// Color of the button
  final Color? color;
  /// Whether the button is disabled or not
  final bool disabled;
  /// Action to perform when tapping the button
  final Function() onBack;
  const MRMBackButton({
    Key? key,
    this.width,
    this.height = Sizes.mrmButtonDefaultHeight / 1.5,
    this.color = Colors.blueGrey,
    this.disabled = false,
    required this.onBack
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: Margins.margin8, horizontal: Margins.margin8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RRadius.radius16),
          color: disabled ? Colors.black26 : color,
          boxShadow: disabled ? null : [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey : Colors.black26,
              blurRadius: 4,
              offset: const Offset(0, 4)
            )
          ]
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: disabled ? null : onBack,
          borderRadius: BorderRadius.circular(RRadius.radius16),
          child: Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: Margins.margin8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(RRadius.radius16)
            ),
            child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
