import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/Utilities/app_constent.dart';
import 'package:karaz_user/Utilities/general.dart';
import 'package:karaz_user/Utilities/routes/routes_string.dart';
import 'package:karaz_user/Utilities/tools/tools.dart';
import 'package:karaz_user/controller/address.dart';
import 'package:karaz_user/controller/app_user_controller.dart';
import 'package:karaz_user/datamodels/app_user/app_user.dart';
import 'package:karaz_user/main.dart';

class SplashController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  RxString appTitle = 'Taxico'.tr.obs;
  bool? firstTime = false;
  @override
  void onInit() async {
    super.onInit();
    // FirebaseAuth.instance.signOut();
    Get.lazyPut<AddressController>(() => AddressController());
    Get.lazyPut<AppUserController>(() => AppUserController());
    firstTime = box.read(AppConstants.ONBOARDING);
    final ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
      await Get.find<AddressController>().getCurrentLocation();
      if (firstTime == false || firstTime == null) {
        Get.offAndToNamed(RoutesString.onboarding);
        return;
      }
      // here check if user logged in
      bool data = FirebaseAuth.instance.currentUser?.uid != null;
      if (data) {
        appUserData.value = await Get.find<AppUserController>()
            .getUserDetails(FirebaseAuth.instance.currentUser!.uid)?? AppUserData();
        Get.offAndToNamed(RoutesString.home);
        return;
      }
      Get.offAndToNamed(RoutesString.welcome);
    } else {
      await checkMobileDataOrWifi(Get.context!);
    }
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) async {
    connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.wifi &&
        connectivityResult != ConnectivityResult.mobile) {
      Get.back();
      await checkMobileDataOrWifi(Get.context!);
      return;
    }
  }

  Future<bool> checkMobileDataOrWifi(BuildContext context) async {
    appTools.showAlertDialogOneFun(
      context,
      onTap: () async {
        Get.back();
        ConnectivityResult connectivityResult =
            await (Connectivity().checkConnectivity());
        if (connectivityResult != ConnectivityResult.wifi &&
            connectivityResult != ConnectivityResult.mobile) {
          Get.back();
          await checkMobileDataOrWifi(Get.context!);
        }
      },
      content: 'Unfortunately You Are Not Connected'.tr,
    );
    return false;
  }
}
