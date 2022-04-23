import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';

class MRMRoundedButton extends StatelessWidget {
  final Function() onTap;
  /// Child to paint within the center of the button
  final Widget child;
  /// Ratio to get the size of the button (device's width / ratio). Defaults to 5.
  final double ratio;
  const MRMRoundedButton({
    Key? key,
    required this.onTap,
    required this.child,
    this.ratio = 5
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width / ratio;
    final color = Theme.of(context).brightness == Brightness.light
        ? Colors.black : Colors.white;

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(RRadius.radius64),
          child: Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              child: child
          ),
        ),
      ),
    );
  }
}
