// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:karaz_user/screens/splash/splash_binding.dart';
import 'package:karaz_user/screens/splash/splash_view.dart';

import '../brand_colors.dart';

// ignore: use_key_in_widget_constructors
class PermissionLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.only(top: 200, left: 10, right: 10, bottom: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'تحذير',
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            Text(
              'الرجاء تفعيل تحديد الموقع',
              style: TextStyle(fontSize: 23),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Image.asset('images/desticon1.png'),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: BrandColors.colorAccent1,
                  borderRadius: BorderRadius.circular(15)),
              child: TextButton(
                child: Text(
                  'حسنا',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  if (await Permission
                      .locationWhenInUse.serviceStatus.isEnabled) {
                    Navigator.pop(context);
                    Get.offAll(() => SplashView(), binding: SplashBinding());
                  } else {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) => PermissionLocation(),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
