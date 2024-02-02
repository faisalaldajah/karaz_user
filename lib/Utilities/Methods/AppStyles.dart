import 'package:flutter/material.dart';
import 'package:karaz_user/theme/app_colors.dart';

class AppStyles {
  static BoxShadow primaryShadow = BoxShadow(
    color: AppColors.black.withOpacity(0.16),
    blurRadius: 10,
    spreadRadius: 0.5,
    offset: const Offset(0, 3),
  );

  static BoxShadow shadowLeft = BoxShadow(
    color: AppColors.black.withOpacity(0.16),
    blurRadius: 10,
    spreadRadius: 0.5,
    offset: const Offset(-3, 0),
  );

  static const double borderRadius = 10.0;
}
