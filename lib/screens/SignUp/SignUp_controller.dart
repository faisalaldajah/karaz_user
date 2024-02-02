// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:karaz_user/Services/AuthenticationService/Core/manager.dart';
import 'package:karaz_user/Utilities/app_constent.dart';
import 'package:karaz_user/Utilities/general.dart';
import 'package:karaz_user/Utilities/routes/routes_string.dart';
import 'package:karaz_user/datamodels/address/addresses.dart';
import 'package:karaz_user/datamodels/app_user/app_user.dart';

class SignUpController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Rx<TextEditingController> fullNameController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  final GlobalKey<FormState> registrationKey = GlobalKey<FormState>();
  RxBool showPassword = true.obs;
  RxBool eightCharacter = false.obs,
      characterCase = false.obs,
      numberOfDigit = false.obs;

  Future<void> registerUser() async {
    Get.find<AuthenticationManager>().commonTools.showLoading();
    try {
      final UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.value.text,
        password: passwordController.value.text,
      );

      Get.back();
      if (user.user != null) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        AddressModel addressModel = AddressModel(
          address: '',
          addressType: '',
          house: '',
          latitude: position.latitude,
          longitude: position.longitude,
          floor: '',
          contactPersonName: '',
          contactPersonNumber: '',
        );
        appUserData.value = AppUserData(
          currentAdrress: addressModel,
          email: emailController.value.text,
          enableNotification: 'true',
          fullName: fullNameController.value.text,
          phoneNumber: phoneController.value.text,
          id: user.user!.uid,
        );
        DatabaseReference ref = FirebaseDatabase.instance
            .ref('${AppConstants.USER}/${appUserData.value.id}');
        ref.set(appUserData.value.toJson());
        Get.offAndToNamed(RoutesString.home);
      }
    } on FirebaseAuthException catch (e) {
      Get.back();
      Get.find<AuthenticationManager>().commonTools.showFailedSnackBar(e.code);
    }
  }
}
