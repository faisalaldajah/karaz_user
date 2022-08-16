// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/Services/AuthenticationService/Core/manager.dart';
import 'package:karaz_user/screens/splash/splash_binding.dart';
import 'package:karaz_user/screens/splash/splash_view.dart';

class SignUpController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Rx<TextEditingController> fullNameController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  AuthenticationManager authManager = Get.find();
  final GlobalKey<FormState> registrationKey = GlobalKey<FormState>();
  RxBool showPassword = true.obs;
  RxBool eightCharacter = false.obs,
      characterCase = false.obs,
      numberOfDigit = false.obs;

  Future<void> registerUser() async {
    authManager.commonTools.showLoading();
    try {
      final UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.value.text,
        password: passwordController.value.text,
      );

      Get.back();
      if (user.user != null) {
        DatabaseReference newUserRef =
            FirebaseDatabase.instance.ref().child('users/${user.user!.uid}');
        Map userMap = {
          'fullname': fullNameController.value.text,
          'email': emailController.value.text,
          'phone': phoneController.value.text,
        };
        newUserRef.set(userMap);
        Get.to(() => const SplashView(), binding: SplashBinding());
      }
    } on FirebaseAuthException catch (e) {
      Get.back();
      authManager.commonTools.showFailedSnackBar(e.code);
    }
  }
}
