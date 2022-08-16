import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/Utilities/Constants/AppColors.dart';
import 'package:karaz_user/globalvariable.dart';
import 'package:karaz_user/screens/mainPage/main_page_controller.dart';
import 'package:karaz_user/styles/styles.dart';
import 'package:karaz_user/widgets/BrandDivier.dart';
import 'package:http/http.dart' as http;

class TheDrawer extends StatelessWidget {
  const TheDrawer({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final MainPageController controller;
  String constructFCMPayload(String? token) {
    return jsonEncode({
      'token': token,
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
        'count': '500',
      },
      'notification': {
        'title': 'Hello FlutterFire!',
        'body': 'This notification (#500) was created via FCM!',
      },
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 160,
            child: DrawerHeader(
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'images/user_icon.png',
                    height: 60,
                    width: 60,
                  ),
                  const SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        currentUserInfo!.fullname!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Brand-Bold',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          BrandDivider(),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(
              Icons.card_giftcard,
              color: AppColors.primary,
            ),
            title: Text(
              'Free Rides',
              style: kDrawerItemStyle,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.credit_card,
              color: AppColors.primary,
            ),
            title: Text(
              'Payments',
              style: kDrawerItemStyle,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.history,
              color: AppColors.primary,
            ),
            title: Text(
              'Ride History',
              style: kDrawerItemStyle,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.contact_support,
              color: AppColors.primary,
            ),
            title: Text(
              'Support',
              style: kDrawerItemStyle,
            ),
          ),
          ListTile(
            onTap: () async {
              await http.post(
                Uri.parse('https://fcm.googleapis.com/fcm/send'),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                  'Authorization':
                      'key=AAAAfSv3M30:APA91bGsv2U2KFDn-hGhSyGn5chdUsPRkERjZoDc05H4RoM6_bqL3Sl43Eb5X2lL5RjhfxzuCV1wxRdq55Xs2mDtq_aRihj2kZNVdYRB9eS6WV0nqjBGM4pY7qG1N4fi4UvnxTWFGFMU '
                },
                body: jsonEncode(
                  <String, dynamic>{
                    'notification': <String, dynamic>{
                      'body': 'body',
                      'title': 'title'
                    },
                    'priority': 'high',
                    'data': <String, dynamic>{
                      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                      'id': '1',
                      'status': 'done'
                    },
                    'to': 'fvnRLLV8RgC4TwBRZg832P:APA91bFRZjzgpjtPPLffLqQ0OlHsYFSsE88xnM0yXvLGh86QA41kpmczu3Ad5jca0GdwP1CchHAHW_bfPKsurocrVXVWudpn6aFdL3aybJGUJHEvBeL8ZJAQpRQLp-_hGm62_m1QZp1U',
                  },
                ),
              );
            },
            leading: const Icon(
              Icons.info,
              color: AppColors.primary,
            ),
            title: Text(
              'about'.tr,
              style: kDrawerItemStyle,
            ),
          ),
          ListTile(
            onTap: controller.signOut,
            leading: const Icon(
              Icons.contact_support,
              color: AppColors.primary,
            ),
            title: Text(
              'logout'.tr,
              style: kDrawerItemStyle,
            ),
          ),
        ],
      ),
    );
  }
}
