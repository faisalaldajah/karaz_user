// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/Utilities/Constants/AppColors.dart';
import '../brand_colors.dart';

class GradientButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  // ignore: use_key_in_widget_constructors
  const GradientButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.8,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              BrandColors.colorAccent1,
              BrandColors.colorAccent,
              BrandColors.colorAccent1,
            ]),
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 0.3,
            color: BrandColors.colorTextLight,
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title.tr,
          style: Get.textTheme.headline4!.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
