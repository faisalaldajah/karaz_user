// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/brand_colors.dart';
import 'package:karaz_user/rideVaribles.dart';
import 'package:karaz_user/screens/mainPage/main_page_controller.dart';
import 'package:karaz_user/widgets/BrandDivier.dart';
import 'package:url_launcher/url_launcher.dart';

class TripSheet extends GetView<MainPageController> {
  const TripSheet({
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
                  0.7, // M)ove to right 10  horizontally
                  0.7, // Move to bottom 10 Vertically
                ),
              )
            ],
          ),
          height: controller.tripSheetHeight.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tripStatusDisplay.value,
                      textAlign: TextAlign.center,
                      style: Get.textTheme.headline5,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                BrandDivider(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  driverFullName,
                  style: Get.textTheme.headline4,
                ),
                Text(
                  driverCarDetails == null ? '' : driverCarDetails!,
                  style: Get.textTheme.headline4,
                ),
                const SizedBox(
                  height: 20,
                ),
                BrandDivider(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular((25))),
                            border: Border.all(
                                width: 1.0, color: BrandColors.colorTextLight),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.call),
                            onPressed: () {
                              launch('tel:${driverPhoneNumber.toString()}');
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Call'),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular((25))),
                            border: Border.all(
                                width: 1.0, color: BrandColors.colorTextLight),
                          ),
                          child: const Icon(Icons.list),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Details'),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular((25))),
                            border: Border.all(
                                width: 1.0, color: BrandColors.colorTextLight),
                          ),
                          child: const Icon(Icons.clear),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Cancel'),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
