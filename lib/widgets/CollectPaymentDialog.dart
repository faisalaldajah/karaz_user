// ignore_for_file: file_names, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace

import 'package:get/get.dart';
import 'package:karaz_user/brand_colors.dart';
import 'package:karaz_user/widgets/BrandDivier.dart';
import 'package:karaz_user/widgets/TaxiButton.dart';
import 'package:flutter/material.dart';

class CollectPayment extends StatelessWidget {
  final String paymentMethod;
  final int fares;

  CollectPayment({required this.paymentMethod, required this.fares});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(4.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(paymentMethod.toUpperCase() + 'payment'.tr),
            SizedBox(
              height: 20,
            ),
            BrandDivider(),
            SizedBox(
              height: 16.0,
            ),
            Text(
              '$fares JD',
              style: Get.textTheme.headline1,
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Amount above is the total fares to be charged to the driver'
                    .tr,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 230,
              child: TaxiButton(
                title:
                    (paymentMethod == 'cash'.tr) ? 'PAY CASH'.tr : 'confirm'.tr,
                color: BrandColors.colorGreen,
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
