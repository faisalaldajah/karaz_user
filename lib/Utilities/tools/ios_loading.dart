import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karaz_user/theme/app_colors.dart';

class IosLoading extends StatelessWidget {
  const IosLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.black.withOpacity(0.8),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Theme(
              data: ThemeData(
                cupertinoOverrideTheme: const CupertinoThemeData(
                  brightness: Brightness.dark,
                ),
              ),
              child: const CupertinoActivityIndicator(
                radius: 17.0,
                color: AppColors.magenta,
              ),
            ),
          ),
        ),
      );
}
