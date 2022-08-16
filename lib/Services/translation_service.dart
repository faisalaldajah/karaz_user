import 'dart:ui';
import 'package:get/get.dart';
import 'package:karaz_user/Utilities/Lang/ar.dart';
import 'package:karaz_user/Utilities/Lang/en.dart';

class TranslationService extends Translations {
  
  static const locale =  Locale('ar', 'SA');

  static const fallbackLocale =  Locale('ar', 'SA');

  static final langs = [
    'en_US',
    'ar_SA',
  ];

  static final locales = [
    const Locale('en', 'US'),
    const Locale('ar', 'SA'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'ar_SA': ar,
      };

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  Locale _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale!;
  }

  bool isLocaleArabic (){
    return Get.locale == const Locale('ar', 'SA');
  }
}
