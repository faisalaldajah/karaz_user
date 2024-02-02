import 'package:flutter/material.dart';

class ButtonStaggerAnimation extends StatelessWidget {
  const ButtonStaggerAnimation({
    Key? key,
    required this.controller,
    required this.color,
    required this.progressIndicatorColor,
    required this.progressIndicatorSize,
    required this.borderRadius,
    required this.onPressed,
    required this.strokeWidth,
    required this.child,
  }) : super(key: key);
  final AnimationController controller;
  final Color color;
  final Color progressIndicatorColor;
  final double progressIndicatorSize;
  final BorderRadius borderRadius;
  final double strokeWidth;
  final Function(AnimationController) onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      LayoutBuilder(builder: _progressAnimatedBuilder);

  Widget _buttonChild() {
    if (controller.isAnimating) {
      return Container();
    } else if (controller.isCompleted) {
      return OverflowBox(
        maxWidth: progressIndicatorSize,
        maxHeight: progressIndicatorSize,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(progressIndicatorColor),
        ),
      );
    }
    return child;
  }

  AnimatedBuilder _progressAnimatedBuilder(
    BuildContext context,
    BoxConstraints constraints,
  ) {
    double buttonHeight = (constraints.maxHeight != double.infinity)
        ? constraints.maxHeight
        : 60.0;

    Animation<double> widthAnimation = Tween<double>(
      begin: constraints.maxWidth,
      end: buttonHeight,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    Animation<BorderRadius> borderRadiusAnimation = Tween<BorderRadius>(
      begin: borderRadius,
      end: BorderRadius.all(Radius.circular(buttonHeight / 2.0)),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) => SizedBox(
        height: buttonHeight,
        width: widthAnimation.value,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadiusAnimation.value,
            ),
          ),
          child: _buttonChild(),
          onPressed: () {
            onPressed(controller);
          },
        ),
      ),
    );
  }
}
