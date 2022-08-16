// ignore_for_file: file_names, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/brand_colors.dart';
import 'package:karaz_user/datamodels/address.dart';
import 'package:karaz_user/datamodels/prediction.dart';
import 'package:karaz_user/globalvariable.dart';
import 'package:karaz_user/screens/mainPage/main_page_controller.dart';

class PredictionTile extends GetView<MainPageController> {
  final Prediction prediction;
  PredictionTile({required this.prediction});
  static final Dio httpClient = Dio();
  void getPlaceDetails(String placeID, context) async {
    controller.authManager.commonTools.showLoading();
    var response = await httpClient.get(
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeID&key=$mapKey');

    //var response = await RequestHelper.getRequest(url);

    Get.back();

    if (response.statusCode != 200) {
      return;
    }

    if (response.data['status'] == 'OK') {
      Address thisPlace = Address();
      thisPlace.placeName = response.data['result']['name'];
      thisPlace.placeId = placeID;
      thisPlace.latitude =
          response.data['result']['geometry']['location']['lat'];
      thisPlace.longitude =
          response.data['result']['geometry']['location']['lng'];
      log(thisPlace.latitude.toString());
      controller.destinationAddress.value = thisPlace;
      controller.seaechPageResponse.value = 'getDirection';
      log('message');
      controller.showDetailSheet('');
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: TextButton(
        onPressed: () {
          getPlaceDetails(prediction.placeId!, context);
        },
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 8,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: BrandColors.colorDimText,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          prediction.mainText!,
                          overflow: TextOverflow.ellipsis,
                          style: Get.textTheme.headline5,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          prediction.secondaryText!,
                          overflow: TextOverflow.ellipsis,
                          style: Get.textTheme.headline6,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
