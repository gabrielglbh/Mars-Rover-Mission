import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';

class MRMInput extends StatelessWidget {
  /// Whether this widget is horizontally rotated or not
  final bool isVertical;
  /// Hint text to show on the [TextField] when it is not used
  final String hint;
  /// [TextEditingController] for handling the [TextField] input
  final TextEditingController? controller;
  /// [FocusNode] for the [TextField]
  final FocusNode? focusNode;
  /// Action to perform when the user taps on the Input Action on the Soft Keyboard
  final Function onEditingComplete;
  /// Action to perform when the user taps on the Input Action NEXT or PREVIOUS on the Soft Keyboard
  final Function(String)? onSubmitted;
  /// [TextInputType] of the Soft Keyboard, defaults to [TextInputType.number]
  final TextInputType? inputType;
  /// [TextInputAction] of the Soft Keyboard, defaults to [TextInputAction.next]
  final TextInputAction? action;
  /// Font size of the text being inputted by the user, defaults to 26
  final double? fontSize;
  /// Whether to autofocus the [TextField] or not
  final bool autofocus;
  const MRMInput({
    Key? key,
    this.isVertical = false,
    required this.hint,
    this.controller,
    this.focusNode,
    required this.onEditingComplete,
    this.onSubmitted,
    this.inputType = TextInputType.number,
    this.action = TextInputAction.next,
    this.autofocus = false,
    this.fontSize = FontSizes.fontSize26
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isVertical) {
      return RotatedBox(
        quarterTurns: 3,
        child: _input(),
      );
    }
    return _input();
  }

  Widget _input() {
    return SizedBox(
      width: Sizes.mrmInputDefaultWidth,
      height: Sizes.mrmInputDefaultHeight,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(fontSize: fontSize),
        textAlign: TextAlign.center,
        textInputAction: action,
        keyboardType: inputType,
        autofocus: autofocus,
        maxLength: 5,
        decoration: InputDecoration(hintText: hint, counterText: ""),
        onEditingComplete: () => onEditingComplete(),
        onSubmitted: (val) { if (onSubmitted != null) onSubmitted!(val); }
      ),
    );
  }
}
