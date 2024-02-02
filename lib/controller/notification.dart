import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
class NotoficationController extends GetxController {
  String key =
      'AAAAeZTyi3s:APA91bHnRrU87n-r0OyWIMAphlAd22bWkcXb7b63onReAb_6izLnxJTCxwSB8hqUx50tBvgeYh_6VNqJkWhzOJP8hrm6-YVj7hVB7D9OQfJc2H32AGGwlaWuvNiv85JIl4b0n178oUg5';
  sendNotification({String? token, context, String? tripID}) async {
    token =
        'cyFen5D2QL6J9fvYJJ-8f7:APA91bFLQDl3hHiuFfKf4SKpxb-o5lwIGwuH5VkC2lxJTlfpJj156GjavIgequOEGyfPiprXl4n0ZyVKlkiNKOG4XE_B5I5ONzTBNxYGABK8UvubpVXdnhyZAHtVrXggGfYkA2OLLc-P';
    Map<String, String> headerMap = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $key',
    };

    Map notificationMap = {
      'title': 'NEW TRIP REQUEST',
      'body': 'Destination, '
    };

    Map dataMap = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'ride_id': tripID,
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
      log(response.body.toString());
    } catch (e) {
      Get.log('Status Code $e message $e');
    }
  }
}
