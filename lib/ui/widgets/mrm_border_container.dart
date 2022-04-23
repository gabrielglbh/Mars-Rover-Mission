import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';

class MRMBorderContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  const MRMBorderContainer({
    Key? key,
    required this.child,
    this.margin
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(Margins.margin8),
      margin: margin,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(RRadius.radius16),
      ),
      child: child
    );
  }
}
