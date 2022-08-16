import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:karaz_user/Services/AuthenticationService/Core/manager.dart';
import 'package:karaz_user/Utilities/Constants/AppColors.dart';
import 'package:karaz_user/globalvariable.dart';
import 'package:karaz_user/helpers/helpermethods.dart';
import 'package:karaz_user/screens/LogIn/login_binding.dart';
import 'package:karaz_user/screens/LogIn/loginpage.dart';

import '../../datamodels/address.dart';
import '../../dataprovider/appdata.dart';

class SplashController extends GetxController {
  AuthenticationManager authManager = Get.find();
  Rx<Address> mainPickupAddress = Address().obs;
  Rx<Address> destinationAddress = Address().obs;
  @override
  void onInit() async {
    if (await Permission.location.isDenied) {
      print('object');
      Geolocator.requestPermission();
    }
    if (await Permission.location.isGranted) {
      await setupPositionLocator();
      HelperMethods.getCurrentUserInfo();
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
      } on SocketException catch (_) {
        authManager.commonTools.showFailedSnackBar('No internet connectivity');
      }
    }
    super.onInit();
  }

  Future<void> setupPositionLocator() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    homeAddress.value =
        placemarks[0].street! + '-' + placemarks[0].subLocality!;
    homeAddresscheck.value = true;
    mainPickupAddress.value.latitude = currentPosition!.latitude;
    mainPickupAddress.value.longitude = currentPosition!.longitude;
    mainPickupAddress.value.placeName = homeAddress.value;
    Provider.of<AppData>(Get.context!, listen: false)
        .updatePickupAddress(mainPickupAddress.value);
    pos = LatLng(currentPosition!.latitude, currentPosition!.longitude);
    googlePlex = CameraPosition(target: pos!, zoom: 14);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.to(() => const LoginPage(), binding: LogInBinding());
  }

  Scaffold waitingView() {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Center(
          child: SvgPicture.asset(
            'images/karaz_logo.svg',
            width: Get.width * 0.4,
            height: Get.width * 0.4,
          ),
        ));
  }
}
