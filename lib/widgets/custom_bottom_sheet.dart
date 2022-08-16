import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/Utilities/Constants/AppColors.dart';

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final Widget child;

  const CustomBottomSheet({Key? key, required this.title, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        //color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            Container(height: 10.0),
            Center(
              child: Container(
                height: 5,
                width: Get.width * 0.2,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            Container(height: 15),
            Visibility(
              visible: title != '',
              child: Column(
                children: [
                  Center(
                    child: Text(
                      title,
                      style: Get.textTheme.headline4!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(height: 30.0),
                ],
              ),
            ),
            Center(child: child),
            Container(height: 30.0),
          ],
        ),
      ),
    );
  }
}
