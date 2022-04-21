import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';

class MRMBullet extends StatelessWidget {
  final bool active;
  const MRMBullet({
    Key? key,
    this.active = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Animations.animation300,
      width: Sizes.mrmBulletSize,
      height: Sizes.mrmBulletSize,
      margin: const EdgeInsets.symmetric(horizontal: Margins.margin4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? Colors.black : Colors.black12
      ),
    );
  }
}
