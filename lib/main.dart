// ignore_for_file: use_key_in_widget_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:karaz_user/Utilities/routes/pages.dart';
import 'package:provider/provider.dart';
import 'package:karaz_user/Services/settings_service.dart';
import 'package:karaz_user/Services/translation_service.dart';
import 'package:karaz_user/dataprovider/appdata.dart';
import 'package:karaz_user/globalvariable.dart';
import 'package:karaz_user/screens/LogIn/login_binding.dart';
import 'package:karaz_user/screens/splash/splash_binding.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

GetStorage box = GetStorage();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Get.putAsync(() => SettingsService().init());
  LogInBinding().dependencies();
  SplashBinding().dependencies();
  await GetStorage.init();
  currentFirebaseUser = FirebaseAuth.instance.currentUser;
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: GetMaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        translations: TranslationService(),
        locale: SettingsService().getLocale(),
        fallbackLocale: TranslationService.fallbackLocale,
        theme: Get.find<SettingsService>().getLightTheme(),
        getPages: getPages,
      ),
    );
  }
}
