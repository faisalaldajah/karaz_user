import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:karaz_user/screens/splash/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.waitingView();
  }
}
