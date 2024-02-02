import 'package:flutter/material.dart';
import 'package:karaz_user/theme/text_themes.dart';

class Subtitle1 extends StatelessWidget {
  const Subtitle1({
    Key? key,
    required this.title,
    this.style,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.textDecoration,
    this.color,
    this.fontSize,
  }) : super(key: key);
  final String title;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final Color? color;
  final double? fontSize;
  @override
  Widget build(BuildContext context) => Text(
        title,
        style: style ??
            TextThemeStyle().subtitle1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color ?? Colors.black,
                  fontSize: fontSize ?? 10,
                ),
        maxLines: maxLines ?? 1,
        overflow: overflow ?? TextOverflow.ellipsis,
        textAlign: textAlign ?? TextAlign.start,
      );
}
