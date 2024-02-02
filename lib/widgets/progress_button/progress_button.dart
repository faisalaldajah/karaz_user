// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:karaz_user/theme/app_colors.dart';
import 'package:karaz_user/theme/text_themes.dart';
import 'package:karaz_user/widgets/progress_button/button_stagger_animation.dart';

class ProgressButton extends StatefulWidget {
  const ProgressButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.color = Colors.blue,
    this.strokeWidth = 2,
    this.progressIndicatorColor = Colors.white,
    this.progressIndicatorSize = 30,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.animationDuration = const Duration(milliseconds: 300),
  });
  final Color color;
  final Color progressIndicatorColor;
  final double progressIndicatorSize;
  final BorderRadius borderRadius;
  final Duration animationDuration;
  final double strokeWidth;
  final Function(AnimationController) onPressed;
  final String title;

  @override
  _ProgressButtonState createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton>
    with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Center(
        child: ButtonStaggerAnimation(
          controller: _controller!,
          color: widget.color,
          strokeWidth: widget.strokeWidth,
          progressIndicatorColor: widget.progressIndicatorColor,
          progressIndicatorSize: widget.progressIndicatorSize,
          borderRadius: widget.borderRadius,
          onPressed: widget.onPressed,
          child: Text(
            widget.title,
            style: TextThemeStyle().headline4.copyWith(
                  color: AppColors.defaultBlack,
                  fontWeight: FontWeight.w900,
                  // fontFamily: Get.locale!.languageCode == 'ar'
                  //     ? AppFonts.tajawalReg
                  //     : AppFonts.poppinsReg,
                ),
          ),
        ),
      );
}
