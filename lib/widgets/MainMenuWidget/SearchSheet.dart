// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:karaz_user/Utilities/Constants/AppColors.dart';
import 'package:karaz_user/brand_colors.dart';
import 'package:karaz_user/globalvariable.dart';
import 'package:karaz_user/helpers/helpermethods.dart';
import 'package:karaz_user/screens/mainPage/main_page_controller.dart';
import 'package:karaz_user/screens/mainPage/searchpage.dart';
import 'package:karaz_user/widgets/LocationPin.dart';

class SearchSheet extends GetView<MainPageController> {
  const SearchSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedSize(
        vsync: controller.vsync,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeIn,
        child: Container(
          height: controller.searchSheetHeight.value,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 15.0,
                    spreadRadius: 0.5,
                    offset: Offset(
                      0.7,
                      0.7,
                    ))
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: SingleChildScrollView(
              child: controller.locationOnMap.value &&
                      controller.drawerCanOpen.value
                  ? LocationPin(
                      onPressedDestination: () async {
                        LatLng ps = await controller.getCenter();
                        await HelperMethods.findCordinateAddress(
                            ps, context, 'pickUp');
                        controller.pinStatus.value = 'pickup location';
                      },
                      pinStatus: controller.pinStatus.value,
                      onPressed: () async {
                        LatLng ps = await controller.getCenter();
                        controller.pickUpAdrress.value =
                            await HelperMethods.findCordinateAddress(
                                ps, context, '');
                        controller.showDetailSheet('');
                        controller.locationOnMap.value = false;
                      },
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Container(
                            height: 5,
                            width: 50,
                            decoration: BoxDecoration(
                                color: BrandColors.colorAccent.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Where are you want to going?'.tr,
                          style: Get.textTheme.headline4,
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () async {
                            Get.to(() => SearchPage());
                            if (controller.seaechPageResponse.value ==
                                'getDirection') {
                              controller.showDetailSheet('');
                            }
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.primaryBG.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.search,
                                    color: Colors.black54,
                                    size: 28,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Search Destination'.tr,
                                    style: Get.textTheme.headline5!.copyWith(
                                        color: AppColors.grey.withOpacity(0.7)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Material(
                          child: InkWell(
                            onTap: () {
                              controller.showDetailSheet('Skip');
                            },
                            child: Container(
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(
                                    Icons.location_on,
                                    color: BrandColors.colorAccent1,
                                    size: 26,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'skip'.tr,
                                        style: Get.textTheme.headline5,
                                      ),
                                      const SizedBox(height: 5),
                                      Obx(
                                        () => Text(
                                          homeAddress.value,
                                          style: Get.textTheme.headline6!
                                              .copyWith(color: AppColors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Material(
                          child: InkWell(
                            onTap: () {
                              controller.pinStatus.value = 'direction location';
                              controller.locationOnMap.value = true;
                            },
                            child: Container(
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(
                                    Icons.location_on,
                                    color: BrandColors.colorAccent1,
                                    size: 26,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text('Set location on map'.tr,
                                      style: Get.textTheme.headline5)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
