import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karaz_user/Utilities/Constants/AppColors.dart';

class SettingsService extends GetxService {
  Future<SettingsService> init() async {
    return this;
  }

  ThemeData getLightTheme() {
    return ThemeData(
        backgroundColor: AppColors.white,
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
              textStyle: const TextStyle(
                fontWeight: FontWeight.w300,
              ),
              primary: Colors.white),
        ),
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
        textTheme: GoogleFonts.getTextTheme(
          getLocale().toString().startsWith('ar') ? 'Cairo' : 'Poppins',
          const TextTheme(
            headline6: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                height: 1.2),
            headline5: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                height: 1.2),
            headline4: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                overflow: TextOverflow.ellipsis,
                height: 1.2),
            headline3: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                overflow: TextOverflow.ellipsis,
                height: 1.2),
            headline2: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                height: 1.2),
            headline1: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                height: 1.2),
            subtitle2: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                height: 1.2),
            subtitle1: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                height: 1.2),
            bodyText2: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
              color: AppColors.black,
              height: 1.4,
            ),
            bodyText1: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w300,
                color: AppColors.black,
                height: 1.4),
            caption: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w100,
                color: AppColors.black,
                height: 1.2),
          ),
        ));
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
