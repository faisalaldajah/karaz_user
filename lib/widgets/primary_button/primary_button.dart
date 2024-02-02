import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/theme/app_colors.dart';
import 'package:karaz_user/theme/text_themes.dart';
import 'package:karaz_user/widgets/text/headline3.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.onTap,
    required this.title,
    this.color,
    this.backgroundColor,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 60,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: Headline3(
              title: title,
              style: TextThemeStyle().headline4.copyWith(
                    color: color ?? AppColors.black,
                    // fontFamily: Get.locale!.languageCode == 'ar'
                    //     ? GoogleFonts.tajawal
                    //     : GoogleFonts.poppins,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
