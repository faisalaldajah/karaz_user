import 'package:get/get.dart';
import 'package:karaz_user/screens/mainPage/main_page_controller.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPageController>(() => MainPageController());
  }
}
