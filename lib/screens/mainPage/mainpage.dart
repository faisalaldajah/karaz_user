// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_final_fields, non_constant_identifier_names, deprecated_member_use, sized_box_for_whitespace, missing_return, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:karaz_user/screens/mainPage/home_app_bar.dart';
import 'package:karaz_user/theme/app_colors.dart';
import 'package:karaz_user/Utilities/general.dart';
import 'package:karaz_user/screens/mainPage/main_page_controller.dart';
import 'package:karaz_user/widgets/MainMenuWidget/MenuButton.dart';
import 'package:karaz_user/widgets/MainMenuWidget/RequestSheet.dart';
import 'package:karaz_user/widgets/MainMenuWidget/RideDetailsSheet.dart';
import 'package:karaz_user/widgets/MainMenuWidget/SearchSheet.dart';
import 'package:karaz_user/widgets/MainMenuWidget/TripSheet.dart';

// ignore: must_be_immutable
class MainPage extends GetView<MainPageController> {
  static const String id = 'mainpage';

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int markerIdCounter = 0;

  String markerIdVal({bool increment = false}) {
    String val = 'marker_id_$markerIdCounter';
    if (increment) markerIdCounter++;
    return val;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Obx(
        () => Stack(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(bottom: controller.mapBottomPadding.value),
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: controller.googleCameraPosition(
                      LatLng(
                        cureentAddress.value.latitude!,
                        cureentAddress.value.longitude!,
                      ),
                    ),
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    polylines: controller.polylines,
                    markers: controller.markers,
                    circles: controller.circles,
                  ),
                  (controller.locationOnMap.value)
                      ? Center(
                          child: Icon(
                            Icons.location_pin,
                            color: AppColors.primary,
                            size: 30,
                          ),
                        )
                      : Container()
                ],
              ),
            ),

            ///MenuButtonDraewr
            HomeAppBar(),

            /// SearchSheet
            Positioned(left: 0, right: 0, bottom: 0, child: SearchSheet()),

            /// RideDetailsSheet
            Positioned(left: 0, right: 0, bottom: 0, child: RideDetailsSheet()),

            /// RequestSheet
            Positioned(left: 0, right: 0, bottom: 0, child: RequestSheet()),

            /// TripSheet
            Positioned(left: 0, right: 0, bottom: 0, child: TripSheet()),
          ],
        ),
      ),
    );
  }
}
