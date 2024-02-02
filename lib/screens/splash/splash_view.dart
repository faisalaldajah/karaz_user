import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/Utilities/routes/routes_string.dart';
import 'package:karaz_user/screens/splash/splash_controller.dart';
import 'package:karaz_user/theme/app_colors.dart';
import 'package:karaz_user/theme/text_themes.dart';
import 'package:karaz_user/widgets/text/headline1.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBlack,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => Get.offAndToNamed(RoutesString.onboarding),
              child: Headline1(
                title: controller.appTitle.value,
                style: TextThemeStyle().headline1.copyWith(
                      color: AppColors.primary,
                      fontSize: 60,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
