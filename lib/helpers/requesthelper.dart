import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

class RequestHelper {
  static Future getHttp(String url) async {
    try {
      var response = await Dio().get(url);
      if (response.statusCode == 200) {
        dynamic data = response.data;
        dynamic decodedData = jsonDecode(data);
        return decodedData;
      } else {
        log('response');
        return 'failed';
      }
    } catch (e) {
      print(e);
      return 'failed';
    }
  }
}
