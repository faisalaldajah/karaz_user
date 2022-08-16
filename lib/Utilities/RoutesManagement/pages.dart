// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:karaz_user/screens/splash/splash_binding.dart';
import 'package:karaz_user/screens/splash/splash_view.dart';

part 'routes.dart';

class AppPages {
  static const INITIAL = Routes.START_PAGE;

  static final routes = [
    GetPage(
        name: Routes.START_PAGE,
        page: () => const SplashView(),
        binding: SplashBinding()),
  ];
}
