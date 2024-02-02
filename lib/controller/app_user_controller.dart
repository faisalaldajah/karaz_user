import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:karaz_user/Utilities/app_constent.dart';
import 'package:karaz_user/datamodels/address/addresses.dart';
import 'package:karaz_user/datamodels/app_user/app_user.dart';

class AppUserController extends GetxController {
  void setUserDetails(AppUserData appUser) {}

  Future<AppUserData?> getUserDetails(String? id) async {
    DatabaseReference firebaseDatabase =
        FirebaseDatabase.instance.ref('${AppConstants.USER}/$id');
    DataSnapshot event = await firebaseDatabase.get();
    // Get.log(event.value.toString());
    dynamic data = event.value;
    if (data != null) {
      AppUserData appUser = AppUserData(
        currentAdrress: AddressModel(
          latitude: data[AppConstants.currentAdrress][AppConstants.latitude],
          longitude: data[AppConstants.currentAdrress][AppConstants.longitude],
        ),
        email: data[AppConstants.email],
        fullName: data[AppConstants.fullName],
        phoneNumber: data[AppConstants.phoneNumber],
        id: id,
        imageUrl: '',
        enableNotification: '',
      );

      return appUser;
    }
    return null;
  }

  void setAddresUser(String id, AddressModel addressModel) {}
}
