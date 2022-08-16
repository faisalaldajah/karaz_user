import 'package:get/get.dart';
import 'package:karaz_user/Services/AuthenticationService/Core/cache.dart';
import 'package:karaz_user/Utilities/Constants/tools.dart';
import 'package:karaz_user/Utilities/Methods/tools.dart';

class AuthenticationManager extends GetxController with CacheManager {
  final CommonTools commonTools = CommonTools();
  final DeliveryTools deliveryTools = DeliveryTools();
  final isLogged = false.obs;

  void logOut() {
    isLogged.value = false;
    removeToken();
  }

  void login(String token) async {
    isLogged.value = true;
    //Token is cached
    await saveToken(token);
  }
}
