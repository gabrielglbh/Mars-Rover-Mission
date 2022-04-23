import 'package:flutter/material.dart';

class MRMText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final TextStyle? style;
  final TextAlign textAlign;
  final EdgeInsets? padding;
  const MRMText({
    Key? key,
    required this.text,
    this.maxLines,
    this.textAlign = TextAlign.justify,
    this.style,
    this.padding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme.bodyText1;
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
