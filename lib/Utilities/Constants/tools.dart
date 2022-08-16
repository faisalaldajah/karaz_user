import 'package:get/get.dart';

class DeliveryTools {
 

  // String calculateDistance(lat2, lon2) {
  //   final AuthenticationManager authManager = Get.find();

  //   var lat1 = authManager.appUser.value.locationData!.localPosition!.latitude;
  //   var lon1 = authManager.appUser.value.locationData!.localPosition!.longitude;

  //   var p = 0.017453292519943295;
  //   var c = cos;
  //   var a = 0.5 -
  //       c((lat2 - lat1) * p) / 2 +
  //       c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  //   double distance = 12742 * asin(sqrt(a));
  //   String? result;

  //   if (distance < 1.0) {
  //     result = (distance * 1000.0).toInt().toString() + " " + "m".tr;
  //   } else {
  //     result = distance.toStringAsFixed(1);

  //     if (result[2] == '0') {
  //       result = result.substring(0, 1);
  //     }

  //     result = result + " " + "km".tr;
  //   }

  //   return result;
  // }

  

  String getCorrectAddressName(int type, String title) {
    switch (type) {
      case 0:
        return 'homeLabel'.tr;

      case 1:
        return 'workLabel'.tr;

      default:
        return title;
    }
  }
}
