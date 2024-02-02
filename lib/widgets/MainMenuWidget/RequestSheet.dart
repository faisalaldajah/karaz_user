// ignore_for_file: deprecated_member_use, file_names
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/brand_colors.dart';
import 'package:karaz_user/screens/mainPage/main_page_controller.dart';

class RequestSheet extends GetView<MainPageController> {
  const RequestSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedSize(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeIn,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 15.0, // soften the shadow
                spreadRadius: 0.5, //extend the shadow
                offset: Offset(
                  0.7, // Move to right 10  horizontally
                  0.7, // Move to bottom 10 Vertically
                ),
              )
            ],
          ),
          height: controller.requestingSheetHeight.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextLiquidFill(
                    text: 'Requesting a Ride...',
                    waveColor: BrandColors.colorTextSemiLight,
                    boxBackgroundColor: Colors.white,
                    textStyle: const TextStyle(
                        color: BrandColors.colorText,
                        fontSize: 22.0,
                        fontFamily: 'Brand-Bold'),
                    boxHeight: 40.0,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    controller.cancelRequest();
                    controller.resetApp();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          width: 1.0, color: BrandColors.colorLightGrayFair),
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 25,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Cancel ride',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
