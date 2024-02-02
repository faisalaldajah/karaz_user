import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/Utilities/app_constent.dart';
import 'package:karaz_user/Utilities/routes/routes_string.dart';
import 'package:karaz_user/main.dart';
import 'package:karaz_user/screens/onbording/onbording_controller.dart';
import 'package:karaz_user/screens/onbording/widget/intro_page_1.dart';
import 'package:karaz_user/screens/onbording/widget/intro_page_2.dart';
import 'package:karaz_user/screens/onbording/widget/intro_page_3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends GetView<OnboardingController> {
  OnBoardingScreen({super.key});

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            PageView(
              controller: controller.pageController,
              onPageChanged: (index) {
                controller.onLastPage.value = (index == 2);
              },
              children: const [
                IntroPage1(),
                IntroPage2(),
                IntroPage3(),
              ],
            ),
            Container(
              alignment: const Alignment(0, 0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.offAndToNamed(RoutesString.welcome);
                      },
                      child: const Text('skip')),
                  SmoothPageIndicator(
                    controller: controller.pageController,
                    count: 3,
                  ),
                  controller.onLastPage.value
                      ? GestureDetector(
                          onTap: () {
                            box.write(AppConstants.ONBOARDING, true);
                            Get.offAndToNamed(RoutesString.welcome);
                          },
                          child: const Text('done'),
                        )
                      : GestureDetector(
                          onTap: () {
                            controller.pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: const Text('next')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
