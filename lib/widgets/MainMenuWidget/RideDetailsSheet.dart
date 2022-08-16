// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/Utilities/Constants/AppColors.dart';
import 'package:karaz_user/brand_colors.dart';
import 'package:karaz_user/globalvariable.dart';
import 'package:karaz_user/helpers/firehelper.dart';
import 'package:karaz_user/helpers/helpermethods.dart';
import 'package:karaz_user/screens/mainPage/main_page_controller.dart';

class RideDetailsSheet extends GetView<MainPageController> {
  const RideDetailsSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
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
        height: controller.rideDetailsSheetHeight.value,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                OutlinedButton(
                  onPressed: () {
                    controller.locationOnMap.value = false;
                    controller.appState.value = 'REQUESTING';
                    driverCarStyle = 'driversAvailable';
                    controller.showRequestingSheet();
                    controller.availableDrivers = FireHelper.nearbyDriverList;
                    controller.findDriver();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    color: BrandColors.colorAccent1,
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'images/taxi1.png',
                          height: 70,
                          width: 70,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Taxi',
                              style: Get.textTheme.headline4!
                                  .copyWith(color: AppColors.white),
                            ),
                            Text(
                              (controller.tripDirectionDetails.value
                                          .distanceText !=
                                      null)
                                  ? controller
                                      .tripDirectionDetails.value.distanceText!
                                  : '',
                              style: const TextStyle(
                                fontSize: 16,
                                color: BrandColors.colorBackground,
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Text(
                            (controller.tripDirectionDetails.value
                                        .durationText !=
                                    null)
                                ? 'JD ${HelperMethods.estimateFares(controller.tripDirectionDetails.value)}'
                                : '',
                            style: Get.textTheme.headline4!
                                .copyWith(color: AppColors.white)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    controller.locationOnMap.value = false;
                    controller.appState.value = 'REQUESTING';
                    driverCarStyle = 'economyAvailable';
                    controller.showRequestingSheet();
                    controller.availableDrivers = FireHelper.nearbyDriverList;
                    controller.findDriver();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    color: BrandColors.colorAccent1,
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'images/taxi.png',
                          height: 70,
                          width: 70,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Economy',
                              style: Get.textTheme.headline4!.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                            Text(
                              (controller.tripDirectionDetails.value
                                          .durationText !=
                                      null)
                                  ? controller
                                      .tripDirectionDetails.value.distanceText!
                                  : '',
                              style: Get.textTheme.headline4!
                                  .copyWith(color: AppColors.white),
                            )
                          ],
                        ),
                        Expanded(child: Container()),
                        Text(
                          (controller.tripDirectionDetails.value.durationText !=
                                  null)
                              ? 'JD ${HelperMethods.estimateFares(controller.tripDirectionDetails.value)}'
                              : '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Brand-Bold',
                            color: BrandColors.colorBackground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: const <Widget>[
                      Icon(
                        Icons.money,
                        size: 18,
                        color: BrandColors.colorTextLight,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text('Cash'),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: BrandColors.colorTextLight,
                        size: 16,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
