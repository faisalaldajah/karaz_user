import 'package:get/get.dart';
import 'package:karaz_user/Utilities/routes/routes_string.dart';
import 'package:karaz_user/screens/LogIn/login_binding.dart';
import 'package:karaz_user/screens/LogIn/loginpage.dart';
import 'package:karaz_user/screens/SignUp/signUpView.dart';
import 'package:karaz_user/screens/SignUp/signUp_binding.dart';
import 'package:karaz_user/screens/mainPage/main_page_binding.dart';
import 'package:karaz_user/screens/mainPage/mainpage.dart';
import 'package:karaz_user/screens/onbording/onboarding_view.dart';
import 'package:karaz_user/screens/onbording/onbording_binding.dart';
import 'package:karaz_user/screens/splash/splash_binding.dart';
import 'package:karaz_user/screens/splash/splash_view.dart';
import 'package:karaz_user/screens/welcome/welcome.dart';

List<GetPage<dynamic>>? getPages = [
  GetPage(
    name: '/',
    page: () => const SplashView(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: RoutesString.onboarding,
    page: () => OnBoardingScreen(),
    binding: OnboardingBinding(),
  ),
  GetPage(
    name: RoutesString.welcome,
    page: () => const WelcomeScreen(),
  ),
  GetPage(
    name: RoutesString.login,
    page: () => const LoginPage(),
    binding: LogInBinding(),
  ),
  GetPage(
    name: RoutesString.signUp,
    page: () => SignUpView(),
    binding: SignUpBinding(),
  ),
  GetPage(
    name: RoutesString.home,
    page: () => MainPage(),
    binding: MainPageBinding(),
  )
];
