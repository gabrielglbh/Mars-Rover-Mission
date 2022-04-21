import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';

class MRMScaffold extends StatelessWidget {
  /// Body of the scaffold
  final Widget child;
  /// Appbar title text
  final String? title;
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
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            title ?? "",
            style: Theme.of(context).textTheme.headline6
          ),
        ),
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
