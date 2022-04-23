import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/ui/widgets/mrm_text.dart';

class MRMScaffold extends StatelessWidget {
  /// Body of the scaffold
  final Widget child;
  /// Appbar title text
  final String? title;
  /// Appbar action if any
  final List<Widget>? actions;
  /// Action to perform, if any, when user goes back from the app bar
  final Future<bool> Function()? onWillPop;
  /// Displays a Scaffold with an already general padding applied
  const MRMScaffold({
    Key? key,
    required this.child,
    this.title,
    this.actions,
    this.onWillPop
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: MRMText(
            text: title ?? " ",
            fit: BoxFit.fitWidth,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6
          ),
          centerTitle: true,
          actions: actions,
        ),
        body: SafeArea(
          child: GestureDetector(
            /// Remove keyboard on touch anywhere else
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            /// Dismiss keyboard if possible whenever a vertical or horizontal
            /// drag down occurs on screen
            onVerticalDragStart: (details) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onHorizontalDragStart: (details) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Margins.margin16,
                horizontal: Margins.margin16
              ),
              child: Center(
                child: Column(
                  children: [
                    Expanded(child: child)
                  ],
                ),
              )
            ),
          )
        ),
      ),
    );
  }
}
