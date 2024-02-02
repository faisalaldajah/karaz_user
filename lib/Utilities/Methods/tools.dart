import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:permission_handler/permission_handler.dart';
import 'package:karaz_user/Services/translation_service.dart';
import 'package:karaz_user/theme/app_colors.dart';import 'package:karaz_user/Utilities/Methods/AppStyles.dart';
import 'package:karaz_user/Utilities/Methods/UI.dart';
import 'package:karaz_user/widgets/custom_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonTools {
  TextEditingController otpController = TextEditingController();

  String? passwordValidate(TextEditingController controller) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (controller.text.isEmpty) {
      return 'this field is required'.tr;
    } else if (controller.text.length < 8) {
      return 'invalid password'.tr;
    } else if (regExp.hasMatch(controller.text) == false) {
      return 'please enter valid password'.tr;
    }
    return null;
  }

  Future<String>? fcmTokenUser() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    return fcmToken!;
  }

  String? emailValidate(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return 'this field is required'.tr;
    } else if (!controller.text.contains('@') ||
        !controller.text.contains('.com')) {
      return 'please enter vaild email'.tr;
    }
    return null;
  }

  String? nameValidate(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return 'this field is required'.tr;
    } else if (controller.text.length < 2) {
      return 'pleaseEnterVaildName'.tr;
    }
    return null;
  }

  String? usernameValidate(TextEditingController controller) {
    String pattern = r'^(?=.*?[a-z])';
    RegExp regExp = RegExp(pattern);
    if (regExp.hasMatch(controller.text) == false) {
      return 'this field is required'.tr;
    }
    if (controller.text.isEmpty) {
      return 'this field is required'.tr;
    } else if (controller.text.length < 3) {
      return 'pleaseEnterVaildName'.tr;
    }
    return null;
  }

  String? phoneNumberValidate(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return 'this field is required'.tr;
    }
    if (controller.text
        .contains(RegExp('[a-zA-Zا-ي?=.*!@#\$%^&*(),.?:{}|<>]'))) {
      return 'should be contains numbers only'.tr;
    } else if (controller.text.startsWith('0') == false) {
      return 'phone number must start with 0'.tr;
    } else if (controller.text.length != 10) {
      return 'phone number must be 10 numbers'.tr;
    }

    return null;
  }

  String? expiryDateValidate(TextEditingController controller) {
    if (controller.text.isEmpty) {
      'this field is required'.tr;
    } else if (controller.text.length < 3) {
      'pleaseEnterVaildName'.tr;
    } else if (controller.text
        .contains(RegExp('[a-zA-Zا-ي?=.*!@#\$%^&*(),.?:{}|<>]'))) {
      return 'should be contains numbers only'.tr;
    } else {
      return null;
    }
    return null;
  }

  String? dateValidate(String? value, TextEditingController controller) {
    if (controller.text.isEmpty) {
      value = 'this field is required'.tr;
    } else {
      value = null;
    }
    return value;
  }

  String? idNumberValidate(String? value, TextEditingController controller) {
    if (value == null || value.isEmpty) {
      return value = 'this field is required'.tr;
    }
    if (value.contains(RegExp('[a-zA-Zا-ي?=.*!@#\$%^&*(),.?:{}|<>]'))) {
      return value = 'should be contains numbers only'.tr;
    } else if (value.startsWith('1') == false) {
      return value = 'id number must started with 1'.tr;
    } else if (value.length != 10) {
      return value = 'id number must be 10 numbers'.tr;
    } else {
      value = null;
    }
    return value;
  }

  String? billCostValidate(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return 'this field is required'.tr;
    }
    if (double.tryParse(controller.text) == null) {
      return 'should be contains numbers only'.tr;
    }
    return null;
  }

  String otpValidation(value) {
    final currentotp = otpController.text;
    if (currentotp.isEmpty) {
      value = 'this field is required'.tr;
    } else if (currentotp.length > 6) {
      value = 'this filed should be 6 digits';
    } else {
      value = null;
    }
    return value;
  }

  String? offerPriceValidate(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return 'this field is required'.tr;
    }
    if (double.tryParse(controller.text) == null) {
      return 'should be contains numbers only'.tr;
    }
    return null;
  }

  String? billReasonValidate(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return 'this field is required'.tr;
    }
    return null;
  }

  String? plateLetterCarValidate(
      String? value, TextEditingController controller) {
    if (controller.text.isEmpty) {
      return value = 'this field is required'.tr;
    } else if (controller.text.length < 3) {
      return value = 'enterValidData'.tr;
    } else if (controller.text.contains(RegExp('[?=.*!@#\$%^&*(),.?:{}|<>]'))) {
      return 'should contains letters only'.tr;
    }

    return value = null;
  }

  String? plateNumberCarValidate(
      String? value, TextEditingController controller) {
    if (controller.text.isEmpty) {
      return value = 'this field is required'.tr;
    } else if (controller.text.length < 4) {
      return value = 'enterValidData'.tr;
    } else if (value!.contains(RegExp('[a-zA-Zا-ي?=.*!@#\$%^&*(),.?:{}|<>]'))) {
      return value = 'should be contains numbers only'.tr;
    }

    return value = null;
  }

  String? serviceCostValidate(String? value, TextEditingController controller) {
    if (controller.text.isEmpty) {
      return value = 'this field is required'.tr;
    } else if (controller.text.length < 2) {
      return value = 'enterValidData'.tr;
    } else if (value!.contains(RegExp('[a-zA-Zا-ي?=*!@#\$%^&*(),?:{}|<>]'))) {
      return value = 'should be contains numbers only'.tr;
    }

    return value = null;
  }

  String? neighborhoodValidate(
      String? value, TextEditingController controller) {
    if (controller.text.isEmpty) {
      return value = 'this field is required'.tr;
    }

    return value = null;
  }

  String? buildingNumberValidate(
      String? value, TextEditingController controller) {
    if (controller.value.text.isEmpty || controller.value.text == '') {
      value = 'this field is required'.tr;
      return value;
    } else {
      value = null;
    }
    return null;
  }

  String? requiredFieldValidate(TextEditingController controller) {
    if (controller.value.text.isEmpty || controller.value.text == '') {
      return 'this field is required'.tr;
    }
    return null;
  }

  String? bankAccountNumberValidate(
      String? value, TextEditingController controller, int textLength) {
    if (controller.text.isEmpty ||
        controller.text.isEmpty ||
        controller.text.trim() == '') {
      return 'this field is required'.tr;
    } else if (controller.text.length < textLength && textLength == 24) {
      return 'enterValidIban'.tr;
    } else if (controller.text.length < textLength && textLength == 8) {
      return 'enterValidAccountNumber'.tr;
    }

    return null;
  }

  String? bankIbantNumberValidate(
      String? value, TextEditingController controller, int textLength) {
    if (controller.text.isEmpty ||
        controller.text.isEmpty ||
        controller.text.trim() == '') {
      return 'this field is required'.tr;
    } else if (controller.text.length < textLength &&
        textLength == 24 &&
        controller.text.contains('SA') == true) {
      return 'enterValidIban'.tr;
    } else if (controller.text.length < textLength && textLength == 8) {
      return 'enterValidAccountNumber'.tr;
    } else if (controller.text.contains('SA') == false) {
      return 'enterValidIbanSA'.tr;
    }

    return null;
  }

  String? validatePinputOtp(TextEditingController controller) {
    String pattern = r'^(?=.*?[0-9])';
    RegExp regExp = RegExp(pattern);
    regExp.hasMatch(controller.text);
    if (controller.text.isEmpty) {
      return 'this field is required'.tr;
    } else if (regExp.hasMatch(controller.text) == false) {
      return 'inValidOtp'.tr;
    }
    return null;
  }

  void showSuccessSnackBar(String message, {int duration = 3}) {
    Get.showSnackbar(UI.successSnackBar(
        title: 'success', message: message.tr, duration: duration));
  }

  void showFailedSnackBar(String message) {
    Get.showSnackbar(UI.errorSnackBar(
      title: 'failed',
      message: message.tr,
    ));
  }

  void showWarningSnackBar(String title) {
    Get.showSnackbar(UI.warningSnackBar(
      title: title,
      message: '',
    ));
  }

  String modifiedDate(String date) {
    String dt;
    if (date.contains(' ')) {
      dt = date.substring(0, date.indexOf(' '));
      return dt;
    } else {
      return date;
    }
  }

  String hourDate(String date) {
    String dt;
    if (date.contains('.')) {
      int time = date.indexOf(' ');
      dt = date.substring(time, date.indexOf('.'));
      return dt;
    } else {
      return date;
    }
  }

  void showLoading() {
    Get.dialog(
        Center(
          child: Container(
            width: Get.width * 0.18,
            height: Get.width * 0.18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppStyles.borderRadius),
              color: AppColors.black.withOpacity(0.5),
            ),
            child: Center(
                child: Theme(
                    data: ThemeData(
                        cupertinoOverrideTheme: const CupertinoThemeData(
                            brightness: Brightness.dark)),
                    child: const CupertinoActivityIndicator(
                      radius: 15.0,
                    ))),
          ),
        ),
        barrierColor: Colors.transparent,
        barrierDismissible: false,
        routeSettings: const RouteSettings(name: 'loading'));
  }

  void showLoadingCustom(double backgroundOpacity, Widget widget) {
    Get.dialog(
        Center(
          child: widget,
        ),
        barrierDismissible: true,
        barrierColor: AppColors.white.withOpacity(backgroundOpacity));
  }

  Future<bool> checkPermissionLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Future.error('Location services are disabled.')
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Future.error('Location permissions are denied')
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Future.error('Location permissions are permanently denied, we cannot request permissions.')
      return false;
    }

    return true;
  }

  void unFocusKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  int createRandom() {
    int randomID;
    Random random = Random();
    int randomFirst = random.nextInt(1000000000) + 1000000;
    int randomSecond = random.nextInt(100000) + randomFirst;
    randomID = randomFirst + randomSecond;
    return randomID;
  }

  void showWarningDialogMutliButtons(
      BuildContext context,
      String title,
      String message,
      String fbTitle,
      String sbTitle,
      Color fbColor,
      Color sbColor,
      VoidCallback fbFunction,
      VoidCallback sbFunction) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            title,
            style: Get.textTheme.headline3!.copyWith(color: AppColors.black),
          ),
        ),
        content: Text(
          message,
          style: Get.textTheme.headline6!.copyWith(color: AppColors.black),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: Text(
              fbTitle,
              style: Get.textTheme.headline6!
                  .copyWith(color: fbColor, fontWeight: FontWeight.w500),
            ),
            onPressed: fbFunction,
          ),
          CupertinoDialogAction(
            child: Text(
              sbTitle,
              style: Get.textTheme.headline6!
                  .copyWith(color: sbColor, fontWeight: FontWeight.w500),
            ),
            onPressed: sbFunction,
          )
        ],
      ),
    );
  }

  void showWarningDialogSingleButton(
      BuildContext context,
      String title,
      String message,
      String buttonTitle,
      Color buttonTitleColor,
      VoidCallback buttonFunction) {
    showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            title,
            style: Get.textTheme.headline3!.copyWith(color: AppColors.black),
          ),
        ),
        content: Text(
          message,
          style: Get.textTheme.bodyText2!.copyWith(color: AppColors.black),
          maxLines: 3,
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: Text(
              buttonTitle,
              style: Get.textTheme.headline6!.copyWith(
                  color: buttonTitleColor, fontWeight: FontWeight.w500),
            ),
            onPressed: buttonFunction,
          ),
        ],
      ),
    );
  }

  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  void showCustomBottomSheet(BuildContext context, String title, Widget child) {
    showModalBottomSheet(
        elevation: 5,
        isScrollControlled: true,
        backgroundColor: AppColors.white.withOpacity(0),
        context: context,
        isDismissible: true,
        builder: (BuildContext newContext) {
          return CustomBottomSheet(title: title, child: child);
        });
  }

  String getVerboseDateTimeRep(String date) {
    var dateUTC = DateTime.parse(date.replaceAll('/', '-') + 'Z').toUtc();

    var dateTime = dateUTC.toLocal();

    DateTime now = DateTime.now().toUtc();
    bool isArabic = TranslationService().isLocaleArabic();

    if (now.day == dateTime.day &&
        now.month == dateTime.month &&
        now.year == dateTime.year &&
        now.difference(dateTime).inMinutes < 2) {
      return isArabic ? 'الان' : 'Just Now';
    }

    if (now.day == dateTime.day &&
        now.month == dateTime.month &&
        now.year == dateTime.year &&
        now.difference(dateTime).inMinutes >= 2 &&
        now.difference(dateTime).inMinutes < 60) {
      int diff = now.difference(dateTime).inMinutes;

      return TranslationService().isLocaleArabic()
          ? 'قبل $diff دقيقة'
          : '$diff minutes ago';
    }

    if (now.day == dateTime.day &&
        now.month == dateTime.month &&
        now.year == dateTime.year &&
        now.difference(dateTime).inHours >= 1 &&
        now.difference(dateTime).inHours < 2) {
      int diff = now.difference(dateTime).inHours;

      return isArabic ? 'قبل ساعة' : '$diff hour ago';
    }

    if (now.difference(dateTime).inHours >= 2 &&
        now.difference(dateTime).inHours < 3) {
      int diff = now.difference(dateTime).inHours;

      return isArabic ? 'قبل ساعتين' : '$diff hours ago';
    }

    if (now.difference(dateTime).inHours >= 3 &&
        now.difference(dateTime).inHours <= 10) {
      int diff = now.difference(dateTime).inHours;

      return isArabic ? 'قبل $diff ساعات' : '$diff hours ago';
    }

    if (now.difference(dateTime).inHours > 10 &&
        now.difference(dateTime).inHours <= 24) {
      return isArabic ? 'اليوم' : 'Today';
    }

    if (now.difference(dateTime).inHours > 24 &&
        now.difference(dateTime).inHours <= 48) {
      return isArabic ? 'أمس' : 'Yesterday';
    }

    if (now.difference(dateTime).inDays >= 2 &&
        now.difference(dateTime).inDays <= 6) {
      int diff = now.difference(dateTime).inDays;

      return isArabic ? 'قبل $diff أيام' : '$diff days ago';
    }

    if (now.difference(dateTime).inDays >= 7 &&
        now.difference(dateTime).inDays < 30) {
      int diff = now.difference(dateTime).inDays ~/ 7;

      return isArabic ? 'قبل $diff أسبوع' : '$diff weeks ago';
    }

    if (now.difference(dateTime).inDays > 29 &&
        (now.difference(dateTime).inDays ~/ 30).toInt() < 12) {
      double diff = now.difference(dateTime).inDays / 30;

      int months = diff.toInt();

      return isArabic ? '$months شهر' : '$months month';
    }

    if ((now.difference(dateTime).inDays ~/ 30).toInt() >= 12) {
      double diff = now.difference(dateTime).inDays / 365;

      int years = diff.toInt();

      return isArabic ? '$years س' : '$years y';
    } else {
      return intl.DateFormat.yMMMMd().format(dateTime) +
          ' - ' +
          intl.DateFormat.jm().format(dateTime);
    }
  }

  String getVerboseDateTimeRepFB(DateTime dateTime) {
    DateTime now = DateTime.now().toUtc();
    bool isArabic = TranslationService().isLocaleArabic();

    if (now.day == dateTime.day &&
        now.month == dateTime.month &&
        now.year == dateTime.year &&
        now.difference(dateTime).inMinutes < 2) {
      return isArabic ? 'الان' : 'Just Now';
    }

    if (now.day == dateTime.day &&
        now.month == dateTime.month &&
        now.year == dateTime.year &&
        now.difference(dateTime).inMinutes >= 2 &&
        now.difference(dateTime).inMinutes < 60) {
      int diff = now.difference(dateTime).inMinutes;

      return TranslationService().isLocaleArabic()
          ? 'قبل $diff دقيقة'
          : '$diff minutes ago';
    }

    if (now.day == dateTime.day &&
        now.month == dateTime.month &&
        now.year == dateTime.year &&
        now.difference(dateTime).inHours >= 1 &&
        now.difference(dateTime).inHours < 2) {
      int diff = now.difference(dateTime).inHours;

      return isArabic ? 'قبل ساعة' : '$diff hour ago';
    }

    if (now.difference(dateTime).inHours >= 2 &&
        now.difference(dateTime).inHours < 3) {
      int diff = now.difference(dateTime).inHours;

      return isArabic ? 'قبل ساعتين' : '$diff hours ago';
    }

    if (now.difference(dateTime).inHours >= 3 &&
        now.difference(dateTime).inHours <= 10) {
      int diff = now.difference(dateTime).inHours;

      return isArabic ? 'قبل $diff ساعات' : '$diff hours ago';
    }

    if (now.difference(dateTime).inHours > 10 &&
        now.difference(dateTime).inHours <= 24) {
      return isArabic ? 'اليوم' : 'Today';
    }

    if (now.difference(dateTime).inHours > 24 &&
        now.difference(dateTime).inHours <= 48) {
      return isArabic ? 'أمس' : 'Yesterday';
    }

    if (now.difference(dateTime).inDays >= 2 &&
        now.difference(dateTime).inDays <= 6) {
      int diff = now.difference(dateTime).inDays;

      return isArabic ? 'قبل $diff أيام' : '$diff days ago';
    }

    if (now.difference(dateTime).inDays >= 7 &&
        now.difference(dateTime).inDays < 30) {
      int diff = now.difference(dateTime).inDays ~/ 7;

      return isArabic ? 'قبل $diff أسبوع' : '$diff weeks ago';
    }

    if (now.difference(dateTime).inDays > 29 &&
        (now.difference(dateTime).inDays ~/ 30).toInt() < 12) {
      double diff = now.difference(dateTime).inDays / 30;

      int months = diff.toInt();

      return isArabic ? '$months شهر' : '$months month';
    }

    if ((now.difference(dateTime).inDays ~/ 30).toInt() >= 12) {
      double diff = now.difference(dateTime).inDays / 365;

      int years = diff.toInt();

      return isArabic ? '$years س' : '$years y';
    } else {
      return intl.DateFormat.yMMMMd().format(dateTime) +
          ' - ' +
          intl.DateFormat.jm().format(dateTime);
    }
  }

  void openURL(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) throw 'Could not launch $url';
  }

  int getRandomSmallNumberFromList() {
    var list = [1, 2, 3, 4, 5, 7];
    return getRandomElement(list);
  }

  int getRandomSmallNumberCustomList(var list) {
    return getRandomElement(list);
  }

  T getRandomElement<T>(List<T> list) {
    final random = Random();
    var i = random.nextInt(list.length);
    return list[i];
  }

  // Future<File?> cropImage(File file) async {
  //   File? newFile;

  //   CroppedFile? cropped = await ImageCropper().cropImage(
  //     sourcePath: file.path,
  //     compressQuality: 10,
  //     cropStyle: CropStyle.rectangle,
  //     compressFormat: ImageCompressFormat.jpg,
  //     aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
  //     uiSettings: [
  //       AndroidUiSettings(
  //         toolbarColor: Get.theme.primaryColor,
  //         toolbarTitle: 'Crop Image',
  //         statusBarColor: AppColors.white,
  //         backgroundColor: AppColors.white,
  //         activeControlsWidgetColor: Get.theme.focusColor,
  //       ),
  //       IOSUiSettings(
  //         title: 'Cropper',
  //       ),
  //     ],
  //   );
  //   if (cropped != null) {
  //     newFile = File(cropped.path);
  //   }

  //   return newFile;
  // }

  Future permissionHandlerImage() async {
    if (await Permission.photos.isDenied) {
      Permission.photos.request().isGranted;
    }
    if (await Permission.photos.isLimited) {
      Permission.photos.request().isGranted;
    }
    if (await Permission.photos.isPermanentlyDenied) {
      Permission.photos.request().isGranted;
    }
    if (await Permission.photos.isRestricted) {
      Permission.photos.request().isGranted;
    }
  }

  Future permissionHandlerFile() async {
    if (await Permission.storage.isDenied) {
      Permission.photos.request().isGranted;
    }
    if (await Permission.storage.isLimited) {
      Permission.photos.request().isGranted;
    }
    if (await Permission.storage.isPermanentlyDenied) {
      Permission.photos.request().isGranted;
    }
    if (await Permission.storage.isRestricted) {
      Permission.photos.request().isGranted;
    }
  }

  Future<void> share(
      {required String title,
      String? text,
      String? linkUrl,
      String? chooserTitle}) async {
    await FlutterShare.share(
      title: title,
      text: text,
      linkUrl: linkUrl,
      chooserTitle: chooserTitle,
    );
  }

  Future<Placemark> getAddressPlacemark(LatLng latLng) async {
    Placemark placeMark = Placemark(country: 'none');
    List<Placemark> newPlace = await placemarkFromCoordinates(
        latLng.latitude, latLng.longitude,
        localeIdentifier: 'en');
    placeMark = newPlace[0];

    return placeMark;
  }

  String getHourFromDateString(String date) {
    String hourDate = '';
    List<String> splitterHours = date.split(':');
    hourDate = splitterHours[0].split(' ')[1];
    hourDate += ':';
    hourDate += splitterHours[1];
    return hourDate;
  }

  RxString checkIfProfilePictureForCurrentUser(
      String id, String appUserId, String imageUrl, String appUserImageUrl) {
    if (id == appUserId) return appUserImageUrl.obs;

    return imageUrl.obs;
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(
      String path, int width) async {
    final Uint8List imageData = await getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(imageData);
  }

  String paymentMethodType(int type) {
    switch (type) {
      case 0:
        return 'undefined'.tr;
      case 1:
        return 'Cash'.tr;
      case 2:
        return 'cridet card'.tr;
      case 3:
        return 'wallet'.tr;
      default:
        return 'wallet'.tr;
    }
  }

  Future<void> openMap(double latitude, double longitude) async {
    try {
      String googleUrl =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
      if (await canLaunchUrl(Uri.parse(googleUrl))) {
        await launchUrl(Uri.parse(googleUrl));
      } else {
        throw 'Could not open the map.';
      }
    } on Exception {
      throw Exception('Error on server');
    }
  }
}
