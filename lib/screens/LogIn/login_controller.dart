import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/Services/AuthenticationService/Core/manager.dart';
import 'package:karaz_user/helpers/helpermethods.dart';
import 'package:karaz_user/screens/splash/splash_binding.dart';
import 'package:karaz_user/screens/splash/splash_view.dart';

class LogInController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  AuthenticationManager authManager = Get.find();
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  BuildContext? context;
  final GlobalKey<FormState> loginForm = GlobalKey<FormState>();
  RxBool showPassword = true.obs;

  Future login() async {
    authManager.commonTools.showLoading();
    try {
      final UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.value.text,
        password: passwordController.value.text,
      );

      if (user.user != null) {
        DatabaseReference userRef =
            FirebaseDatabase.instance.ref().child('users/${user.user!.uid}');
        userRef.once().then((snapshot) {
          if (snapshot.snapshot.value != null) {
            HelperMethods.getCurrentUserInfo();
            Get.offAll(() => const SplashView(), binding: SplashBinding());
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      Get.back();
      authManager.commonTools.showFailedSnackBar(e.code);
    }
  }

  @override
  void onInit() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
    } on SocketException catch (_) {
      authManager.commonTools.showFailedSnackBar('No internet connectivity');
    }
    super.onInit();
  }
}
