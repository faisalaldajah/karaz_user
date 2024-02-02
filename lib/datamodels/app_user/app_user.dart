
import 'package:karaz_user/datamodels/address/addresses.dart';

class AppUserData {
  String? email;
  String? id;
  String? fullName;
  String? phoneNumber;
  String? enableNotification;
  String? imageUrl;
  AddressModel? currentAdrress;

  AppUserData(
      {this.email,
      this.id,
      this.fullName,
      this.phoneNumber,
      this.enableNotification,
      this.imageUrl,
      this.currentAdrress});

  AppUserData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    enableNotification = json['enableNotification'];
    imageUrl = json['imageUrl'];
    currentAdrress = json['currentAdrress'] != null
        ? AddressModel.fromJson(json['currentAdrress'])
        : AddressModel();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['id'] = id;
    data['fullName'] = fullName;
    data['phoneNumber'] = phoneNumber;
    data['enableNotification'] = enableNotification;
    data['imageUrl'] = imageUrl;
    if (currentAdrress != null) {
      data['currentAdrress'] = currentAdrress!.toJson();
    }
    return data;
  }
}
