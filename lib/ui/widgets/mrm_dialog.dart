import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/ui/widgets/mrm_text.dart';

class MRMDialog extends StatelessWidget {
  /// Title of the dialog
  final Widget title;
  /// Content of the dialog
  final Widget content;
  /// Text to display within the positive button of the dialog
  final String positiveButtonText;
  /// Whether to show the negative button of the dialog or not
  final bool negativeButton;
  /// Whether to pop the dialog when tapping the positive button or not
  final bool popDialog;
  /// Action to perform when tapping the positive button
  final Function onPositive;
  const MRMDialog({
    Key? key,
    required this.title,
    required this.content,
    this.negativeButton = false,
    required this.positiveButtonText,
    required this.onPositive,
    this.popDialog = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(RRadius.radius16))),
      content: Wrap(children: [content]),
      actions: [
        Visibility(
          visible: negativeButton,
          child: ElevatedButton(
              child: MRMText(text: "cancel_button_label".tr(), style: Theme.of(context).textTheme.subtitle2?.copyWith(
                color: Colors.white
              )),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(RRadius.radius8))),
              ),
              onPressed: () => Navigator.of(context).pop()
          ),
        ),
        ElevatedButton(
            child: MRMText(text: positiveButtonText, style: Theme.of(context).textTheme.subtitle2?.copyWith(
                color: Colors.white
            )),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(RRadius.radius8))),
            ),
            onPressed: () async {
              if (popDialog) Navigator.of(context).pop();
              await onPositive();
            }
        ),
      ],
    );
  }
}