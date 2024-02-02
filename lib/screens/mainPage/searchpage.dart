import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/brand_colors.dart';
import 'package:karaz_user/datamodels/prediction.dart';
import 'package:karaz_user/globalvariable.dart';
import 'package:karaz_user/screens/mainPage/main_page_controller.dart';
import 'package:karaz_user/widgets/BrandDivier.dart';
import 'package:karaz_user/widgets/PredictionTile.dart';

class SearchPage extends GetView<MainPageController> {
  final focusDestination = FocusNode();
  static final Dio httpClient = Dio();

  SearchPage({Key? key}) : super(key: key);

  void setFocus() {
    if (!controller.focused.value) {
      FocusScope.of(Get.context!).requestFocus(focusDestination);
      controller.focused.value = true;
    }
  }

  void searchPlace(String placeName) async {
    Prediction prediction;
    if (placeName.length > 1) {
      var response = await httpClient.get(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=123254251&components=country:jo');

      if (response.statusCode != 200) {
        log(response.statusCode.toString());
        return;
      }
      if (response.statusCode == 200) {
        var items = response.data['predictions'];
        //log(items[0]['structured_formatting']['main_text'].toString());
        for (var key in items) {
          String mainText = key['structured_formatting']['main_text'];
          String secondaryText = key['structured_formatting']['secondary_text'];
          String placeId = key['place_id'];
          prediction = Prediction(
            mainText: mainText,
            placeId: placeId,
            secondaryText: secondaryText,
          );
          controller.destinationPredictionList.add(prediction);
        }
        controller.destinationPredictionList.value = items;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setFocus();
    return Scaffold(
      body: Obx(
        () => ListView(
          children: <Widget>[
            Container(
              height: 210,
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  spreadRadius: 0.5,
                  offset: Offset(
                    0.7,
                    0.7,
                  ),
                ),
              ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 24, top: 48, right: 24, bottom: 20),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 5,
                    ),
                    Stack(
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(Icons.arrow_back)),
                        Center(
                          child: Text(
                            'Set Destination'.tr,
                            style: Get.textTheme.displaySmall,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: <Widget>[
                        Image.asset(
                          'images/pickicon.png',
                          height: 16,
                          width: 16,
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: BrandColors.colorLightGrayFair,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextField(
                                enabled: false,
                                style: Get.textTheme.titleLarge,
                                controller: controller.pickupController,
                                decoration: InputDecoration(
                                    hintText: controller.mainPickupAddress.value
                                                .placeName ==
                                            null
                                        ? ''
                                        : controller
                                            .mainPickupAddress.value.placeName!,
                                    fillColor: BrandColors.colorLightGrayFair,
                                    filled: true,
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 10, top: 8, bottom: 8, right: 8)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Image.asset(
                          'images/desticon.png',
                          height: 16,
                          width: 16,
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: BrandColors.colorLightGrayFair,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextField(
                                onChanged: (value) {
                                  searchPlace(value);
                                },
                                focusNode: focusDestination,
                                controller: controller.destinationController,
                                style: Get.textTheme.titleLarge,
                                decoration: InputDecoration(
                                    hintText: 'Where you to go?'.tr,
                                    fillColor: BrandColors.colorLightGrayFair,
                                    filled: true,
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 10, top: 8, bottom: 8, right: 8)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            (controller.destinationPredictionList.isNotEmpty)
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Obx(
                      () => ListView.separated(
                        padding: const EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          return PredictionTile(
                            prediction:
                                controller.destinationPredictionList[index],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            BrandDivider(),
                        itemCount: controller.destinationPredictionList.length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
