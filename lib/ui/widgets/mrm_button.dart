import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/ui/widgets/mrm_text.dart';

class MRMButton extends StatelessWidget {
  /// Width of the button
  final double? width;
  /// Height of the button
  final double? height;
  /// Color of the button
  final Color? color;
  /// Title of the button,
  final String title;
  /// Icon of the button
  final IconData? icon;
  /// Title color
  final Color titleColor;
  /// Action to perform when tapping the button
  final Function() onTap;
  /// Horizontal padding when in Row
  final double horizontal;
  /// Whether the button is disabled or not
  final bool disabled;
  /// Trailing icon
  final IconData? trailing;
  /// Leading icon
  final IconData? leading;
  const MRMButton({
    Key? key,
    this.width,
    this.height = Sizes.mrmButtonDefaultHeight / 1.5,
    this.color = Colors.blue,
    required this.title,
    required this.onTap,
    this.titleColor = Colors.white,
    this.icon,
    this.horizontal = 0,
    this.disabled = false,
    this.trailing,
    this.leading
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: Margins.margin8, horizontal: horizontal),
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
          onTap: disabled ? null : onTap,
          borderRadius: BorderRadius.circular(RRadius.radius16),
          child: Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: Margins.margin8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(RRadius.radius16)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: icon != null,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: Margins.margin8),
                      child: Icon(icon, color: Colors.white)
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: leading != null || trailing != null,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              right: Margins.margin8, left: Margins.margin16
                          ),
                          child: Icon(leading, color: leading != null
                              ? Colors.white : Colors.transparent)
                      ),
                    ),
                    Expanded(
                      child: MRMText(
                          text: title, textAlign: TextAlign.center, maxLines: 2,
                          style: Theme.of(context).textTheme.button?.copyWith(
                              color: titleColor
                          )),
                    ),
                    Visibility(
                      visible: trailing != null,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: Margins.margin8, right: Margins.margin16
                          ),
                          child: Icon(trailing, color: Colors.white)
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
