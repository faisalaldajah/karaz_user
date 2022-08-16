// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/widgets/GradientButton.dart';
import 'package:karaz_user/widgets/TaxiButton.dart';

class LocationPin extends StatelessWidget {
  LocationPin({
    Key? key,
    required this.pinStatus,
    required this.onPressed,
    required this.onPressedDestination,
  }) : super(key: key);
  String pinStatus;
  VoidCallback onPressed;
  VoidCallback onPressedDestination;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Text(
          'Set your location'.tr,
          style: Get.textTheme.headline3,
        ),
        const SizedBox(height: 20),
        Image.asset('images/desticon.png'),
        const SizedBox(height: 20),
        //TODO
        (pinStatus == 'direction location')
            ? GradientButton(
                title: 'Destination'.tr,
                onPressed: onPressedDestination,
              )
            : TaxiButton(title: 'pickUpMyLocation'.tr, onPressed: onPressed),
      ],
    );
  }
}
