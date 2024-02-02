import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/Services/translation_service.dart';
import 'package:karaz_user/Utilities/images.dart';
import 'package:karaz_user/Utilities/routes/routes_string.dart';
import 'package:karaz_user/theme/app_colors.dart';
import 'package:karaz_user/theme/text_themes.dart';
import 'package:karaz_user/widgets/primary_button/primary_button.dart';
import 'package:karaz_user/widgets/text/headline1.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBlack,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              ImagesAssets.blackCar,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              Center(
                child: Headline1(
                  title: 'Taxico',
                  style: TextThemeStyle().headline1.copyWith(
                        color: AppColors.primary,
                        fontSize: 60,
                      ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: PrimaryButton(
                  onTap: () {
                    Get.toNamed(
                      RoutesString.login,
                    );
                  },
                  title: 'Sign In',
                  color: AppColors.defaultBlack,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: PrimaryButton(
                  onTap: () => Get.toNamed(
                    RoutesString.signUp,
                  ),
                  title: 'Sign Up',
                  color: AppColors.defaultBlack,
                  backgroundColor: AppColors.white,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
          Positioned(
            top: 20,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    InkWell(
                      child: Text(
                        'العربية',
                        style: Get.theme.textTheme.displayLarge!.copyWith(
                            fontSize: 15.0,
                            color: TranslationService().isLocaleArabic()
                                ? AppColors.black
                                : AppColors.white),
                      ),
                      onTap: () {
                        TranslationService().changeLocale('ar_SA');
                      },
                    ),
                    const VerticalDivider(
                      color: AppColors.black,
                    ),
                    InkWell(
                      onTap: () {
                        TranslationService().changeLocale('en_US');
                      },
                      child: Text(
                        'English',
                        style: Get.theme.textTheme.displayLarge!.copyWith(
                            fontSize: 15.0,
                            color: TranslationService().isLocaleArabic()
                                ? AppColors.white
                                : AppColors.black),
                      ),
                    ),
                  ],
                ),
              ).paddingSymmetric(horizontal: 42).marginOnly(top: 20),
            ),
          ),
        ],
      ),
    );
  }
}
