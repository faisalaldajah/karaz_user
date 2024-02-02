import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/theme/text_themes.dart';
import 'countries.dart';
import 'country_code.dart';

Rx<CountryCode> mainCountryCode = nadCountries[110].obs;
CountryCodeMethod myCountryCodeMethod = CountryCodeMethod();

class CountryCodeMethod extends GetxController {
  final Rx<TextEditingController> countryTF = TextEditingController().obs;
  final TextEditingController country = TextEditingController();
  final RxBool countryFocus = false.obs;

  RxList<CountryCode> countries = nadCountries.obs;

  Rx<CountryCode> countryCode = const CountryCode(
    name: '',
    flag: '',
    code: '',
    dialCode: '',
    nameTranslations: <String, String>{},
    minLength: 0,
    maxLength: 0,
  ).obs;

  void setCountryCode(int indexPath) {
    mainCountryCode.value = countries[indexPath];
    log(mainCountryCode.value.code);
    Get.back();
  }

  Widget flagWidget(CountryCode countryCode) => SizedBox(
        child: Text(
          countryCode.flag,
          style: TextThemeStyle().headline3,
        ),
      );

  static String countryCodeToEmoji(String countryCode) {
    final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  List<CountryCode> searchNadCountry(String code) {
    RxList<CountryCode> newNadCountryCode = <CountryCode>[].obs;
    if (code.isEmpty) {
      countries.clear();
      return nadCountries;
    }
    newNadCountryCode.value = nadCountries.where((CountryCode element) {
      return element.nameTranslations['en']
          .toString()
          .toLowerCase()
          .contains(code.toString().toLowerCase());
    }).toList();
    newNadCountryCode.refresh();
    return newNadCountryCode;
  }
}

Future<void> showCustomBottomSheet(
  BuildContext context,
  Widget child,
  bool isDismissible,
) async {
  await showModalBottomSheet(
    enableDrag: false,
    elevation: 5,
    isScrollControlled: true,
    backgroundColor: Colors.white.withOpacity(0.3),
    context: context,
    isDismissible: isDismissible,
    builder: (BuildContext newContext) => SingleChildScrollView(
      child: child,
    ),
  );
}
