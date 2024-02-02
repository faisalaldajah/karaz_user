import 'package:flutter/material.dart';

class CustomePadding extends StatelessWidget {
  const CustomePadding({
    super.key,
    required this.child,
    this.bottom,
    this.left,
    this.right,
    this.top,
  });
  final double? right;
  final double? left;
  final double? bottom;
  final double? top;
  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          top: top ?? 0,
          bottom: bottom ?? 0,
          right: right ?? 0,
          left: left ?? 0,
        ),
        child: child,
      );
}
