import 'package:flutter/material.dart';

class MRMText extends StatelessWidget {
  /// Text to display
  final String text;
  /// Max lines of the displayed text
  final int? maxLines;
  /// Text Style by default. Defaults to bodyText1
  final TextStyle? style;
  /// Alignment of the text. Defaults to justified.
  final TextAlign textAlign;
  final EdgeInsets? padding;
  /// If provided, the text is fitted within the specified definition
  final BoxFit? fit;
  const MRMText({
    Key? key,
    required this.text,
    this.maxLines,
    this.textAlign = TextAlign.justify,
    this.style,
    this.padding,
    this.fit
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme.bodyText1;
    if (fit != null) {
      return Padding(
        padding: padding ?? const EdgeInsets.all(0),
        child: FittedBox(
          fit: fit!,
          child: Text(
            text,
            textAlign: textAlign,
            style: this.style ?? style,
            maxLines: maxLines,
          ),
        ),
      );
    }
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Text(
        text,
        textAlign: textAlign,
        style: this.style ?? style,
        maxLines: maxLines,
      ),
    );
  }
}
