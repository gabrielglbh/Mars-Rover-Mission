import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';

class MRMScaffold extends StatelessWidget {
  /// Body of the scaffold
  final Widget child;
  /// Appbar title widget
  final Widget? title;
  /// Appbar action if any
  final List<Widget>? actions;
  /// Displays a Scaffold with an already general padding applied
  const MRMScaffold({
    Key? key,
    required this.child,
    this.title,
    this.actions
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        actions: actions,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Margins.margin16,
          horizontal: Margins.margin16
        ),
        child: child,
      ),
    );
  }
}
