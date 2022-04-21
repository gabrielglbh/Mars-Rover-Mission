import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';

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
  const MRMButton({
    Key? key,
    this.width,
    this.height = Sizes.mrmButtonDefaultHeight,
    this.color,
    required this.title,
    required this.onTap,
    this.titleColor = Colors.white,
    this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: Margins.margin8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(RRadius.radius16),
        color: color,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            offset: Offset(0, 4)
          )
        ]
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap(),
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
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(title, textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: titleColor,
                        fontSize: FontSizes.fontSize16,
                        fontWeight: FontWeight.bold
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}