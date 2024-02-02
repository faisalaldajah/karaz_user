import 'package:get/get.dart';
import 'package:karaz_user/datamodels/address/addresses.dart';
import 'package:karaz_user/datamodels/app_user/app_user.dart';

Rx<AppUserData> appUserData = AppUserData().obs;
Rx<AddressModel> cureentAddress = AddressModel().obs;
