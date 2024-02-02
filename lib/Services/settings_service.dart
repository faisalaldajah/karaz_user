import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karaz_user/theme/app_colors.dart';

class SettingsService extends GetxService {
  Future<SettingsService> init() async {
    return this;
  }

  ThemeData getLightTheme() {
    return ThemeData(
        primaryColor: AppColors.primary,
        hoverColor: AppColors.success,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 3,
          foregroundColor: AppColors.white,
          highlightElevation: 6,
          disabledElevation: 2,
        ),
        brightness: Brightness.light,
        dividerColor: AppColors.grey,
        focusColor: AppColors.primary,
        hintColor: AppColors.grey,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontWeight: FontWeight.w300,
              )),
        ),
        textTheme: GoogleFonts.getTextTheme(
          getLocale().toString().startsWith('ar') ? 'Cairo' : 'Poppins',
          const TextTheme(
            titleLarge: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                height: 1.2),
            headlineSmall: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                height: 1.2),
            headlineMedium: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                overflow: TextOverflow.ellipsis,
                height: 1.2),
            displaySmall: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                overflow: TextOverflow.ellipsis,
                height: 1.2),
            displayMedium: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                height: 1.2),
            displayLarge: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                height: 1.2),
            titleSmall: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                height: 1.2),
            titleMedium: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                height: 1.2),
            bodyMedium: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
              color: AppColors.black,
              height: 1.4,
            ),
            bodyLarge: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w300,
                color: AppColors.black,
                height: 1.4),
            bodySmall: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w100,
                color: AppColors.black,
                height: 1.2),
          ),
        ),
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ).copyWith(background: AppColors.white));
  }

  Locale getLocale() {
    String? localeLang = GetStorage().read<String>('lang');
    String? localeCountry = GetStorage().read<String>('country');
    Locale locale = localeLang == null || localeCountry == null
        ? const Locale('ar', 'JO')
        : const Locale('en', 'US');

    return locale;
  }
}
