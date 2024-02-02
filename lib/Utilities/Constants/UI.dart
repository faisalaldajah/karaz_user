import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/theme/app_colors.dart';

class UI {
  static GetSnackBar successSnackBar(
      {String title = 'success', String? message, int duration = 3}) {
    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.headlineMedium!.merge(const TextStyle(
              color: AppColors.white, fontWeight: FontWeight.w500))),
      messageText: Text(message!,
          style: Get.textTheme.titleLarge!.merge(const TextStyle(
              color: AppColors.white, fontWeight: FontWeight.w500))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Get.theme.primaryColor,
      icon: const Icon(Icons.check_circle_outline,
          size: 32, color: AppColors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: duration),
    );
  }

  static BoxShadow boxShadow = BoxShadow(
    blurRadius: 4,
    color: AppColors.grey.withOpacity(0.1),
    offset: const Offset(0, 0),
    spreadRadius: 3,
  );

  static GetSnackBar errorSnackBar(
      {String title = 'failed', String? message, int duration = 5}) {
    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.headlineMedium!.merge(const TextStyle(
              color: AppColors.white, fontWeight: FontWeight.w500))),
      messageText: Text(message!,
          style: Get.textTheme.titleLarge!.merge(const TextStyle(
              color: AppColors.white, fontWeight: FontWeight.w500))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.redAccent,
      icon: const Icon(Icons.remove_circle_outline,
          size: 32, color: AppColors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: duration),
    );
  }

  static Color parseColor(String hexCode, {double? opacity}) {
    try {
      return Color(int.parse(hexCode.replaceAll('#', '0xFF')))
          .withOpacity(opacity ?? 1);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity ?? 1);
    }
  }

  static InputDecoration getInputDecoration(
      {String hintText = '', IconData? iconData, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hintText,
      errorMaxLines: 3,
      errorStyle: Get.theme.textTheme.bodyMedium!
          .copyWith(fontWeight: FontWeight.w500, color: Colors.red),
      hintStyle: Get.theme.textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w500, color: AppColors.black.withOpacity(0.8)),
      prefixIcon: iconData != null
          ? Icon(iconData, color: Get.theme.focusColor).marginOnly(right: 14)
          : const SizedBox(),
      prefixIconConstraints: iconData != null
          ? const BoxConstraints.expand(width: 38, height: 38)
          : const BoxConstraints.expand(width: 0, height: 0),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: const EdgeInsets.all(0),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      suffixIcon: suffixIcon,
    );
  }
}
