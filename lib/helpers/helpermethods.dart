import 'dart:convert';
import 'dart:developer';
import 'dart:math' hide log;
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:karaz_user/datamodels/address.dart';
import 'package:karaz_user/datamodels/directiondetails.dart';
import 'package:karaz_user/datamodels/user.dart';
import 'package:karaz_user/dataprovider/appdata.dart';
import 'package:karaz_user/globalvariable.dart';
import 'package:karaz_user/screens/mainPage/main_page_binding.dart';
import 'package:karaz_user/screens/mainPage/main_page_controller.dart';
import 'package:karaz_user/screens/mainPage/mainpage.dart';

class HelperMethods {
  static final Dio httpClient = Dio();
  static void getCurrentUserInfo() async {
    currentFirebaseUser = FirebaseAuth.instance.currentUser;
    String userid = currentFirebaseUser!.uid;
    DatabaseReference userRef =
        FirebaseDatabase.instance.ref().child('users/$userid');
    userRef.once().then((snapshot) {
      if (snapshot.snapshot.value != null) {
        dynamic data = snapshot.snapshot.value;
        currentUserInfo = UserData(
          id: data['id'],
          fullname: data['fullname'],
          email: data['email'],
          phone: data['phone'],
          personalImage: data['personalImage'],
        );
        Get.to(() => MainPage(), binding: MainPageBinding());
      }
    });
  }

  static Future<String> findCordinateAddress(
      LatLng position, context, String locationType) async {
    MainPageController mainPageController = Get.find();
    String? placeAddress;
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      return placeAddress!;
    }

    String url1 =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey';

    var response = await httpClient.get(url1);
    if (response.statusCode == 200) {
      placeAddress = response.data['results'][0]['formatted_address'];
      if (locationType == 'pickUp') {
        Address pickupAddress = Address();
        pickupAddress.longitude = position.longitude;
        pickupAddress.latitude = position.latitude;
        pickupAddress.placeName = placeAddress;
        mainPageController.mainPickupAddress.value = pickupAddress;
        Provider.of<AppData>(context, listen: false)
            .updatePickupAddress(pickupAddress);
      } else {
        Address destinationAddress = Address();
        destinationAddress.longitude = position.longitude;
        destinationAddress.latitude = position.latitude;
        destinationAddress.placeName = placeAddress;
        mainPageController.destinationAddress.value = destinationAddress;
        Provider.of<AppData>(context, listen: false)
            .updateDestinationAddress(destinationAddress);
      }
    }

    return placeAddress!;
  }

  static Future getDirectionDetails(
      LatLng startPosition, LatLng endPosition) async {
    var response = await httpClient.get(
        'https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=$mapKey');

    if (response.statusCode != 200) {
      return null;
    }

    DirectionDetails directionDetails = DirectionDetails();
    directionDetails.durationText =
        response.data['routes'][0]['legs'][0]['duration']['text'];
    directionDetails.durationValue =
        response.data['routes'][0]['legs'][0]['duration']['value'];
    directionDetails.distanceText =
        response.data['routes'][0]['legs'][0]['distance']['text'];
    directionDetails.distanceValue =
        response.data['routes'][0]['legs'][0]['distance']['value'];
    directionDetails.encodedPoints =
        response.data['routes'][0]['overview_polyline']['points'];
    return directionDetails;
  }

  static int estimateFares(DirectionDetails details) {
    // per km = $0.3,
    // per minute = $0.2,
    // base fare = $3,
    double baseFare = 0.6;
    double distanceFare = (details.distanceValue! / 1000) * 0.21;
    double timeFare = (details.durationValue! / 60);
    double totalFare = baseFare + distanceFare + timeFare;
    return totalFare.truncate();
  }

  static double generateRandomNumber(int max) {
    var randomGenerator = Random();
    int randInt = randomGenerator.nextInt(max);

    return randInt.toDouble();
  }

  static sendNotification({String? token, context, String? rideId}) async {
    print(rideId!);
    var destination =
        Provider.of<AppData>(context, listen: false).pickupAddress;
    Map<String, String> headerMap = {
      'Content-Type': 'application/json',
      'Authorization': serverKey,
    };

    Map notificationMap = {
      'title': 'NEW TRIP REQUEST',
      'body': 'Destination, ${destination!.placeName}'
    };

    Map dataMap = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'ride_id': rideId,
    };

    Map bodyMap = {
      'notification': notificationMap,
      'data': dataMap,
      'priority': 'high',
      'to': token
    };
    try {
      var response = await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: headerMap,
          body: jsonEncode(bodyMap));
      log(response.statusCode.toString());
    } on DioError catch (e) {
      Get.log('Status Code ${e.response!.statusCode} message ${e.response}');
    }
  }
}
