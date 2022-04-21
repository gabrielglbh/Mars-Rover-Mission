import 'package:flutter/material.dart';

class MRMRoundedButton extends StatelessWidget {
  final Function() onTap;
  /// Child to paint within the center of the button
  final IconData icon;
  /// Ratio to get the size of the button (device's width / ratio). Defaults to 5.
  final double ratio;
  /// Color of the button. Defaults to blue
  final Color color;
  const MRMRoundedButton({
    Key? key,
    required this.onTap,
    required this.icon,
    this.ratio = 5,
    this.color = Colors.black
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width / ratio;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      alignment: Alignment.center,
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white)
      ),
    );
  }
}
