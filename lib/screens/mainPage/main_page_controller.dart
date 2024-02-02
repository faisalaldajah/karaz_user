import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:karaz_user/Services/AuthenticationService/Core/manager.dart';
import 'package:karaz_user/Utilities/general.dart';
import 'package:karaz_user/brand_colors.dart';
import 'package:karaz_user/datamodels/address.dart';
import 'package:karaz_user/datamodels/directiondetails.dart';
import 'package:karaz_user/datamodels/driver.dart';
import 'package:karaz_user/datamodels/nearbydriver.dart';
import 'package:karaz_user/datamodels/prediction.dart';
import 'package:karaz_user/dataprovider/appdata.dart';
import 'package:karaz_user/globalvariable.dart';
import 'package:karaz_user/helpers/helpermethods.dart';
import 'package:karaz_user/rideVaribles.dart';
import 'package:karaz_user/screens/LogIn/login_binding.dart';
import 'package:karaz_user/screens/LogIn/loginpage.dart';
import 'package:karaz_user/widgets/CollectPaymentDialog.dart';
import 'package:karaz_user/widgets/NoDriverDialog.dart';
import 'package:karaz_user/widgets/ProgressDialog.dart';
import 'package:provider/provider.dart';

class MainPageController extends GetxController {
  AuthenticationManager authManager = Get.find();
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  RxList<Prediction> destinationPredictionList = <Prediction>[].obs;
  RxString seaechPageResponse = ''.obs;
  RxDouble searchSheetHeight = 300.0.obs;
  RxDouble rideDetailsSheetHeight = 0.0.obs; // (Platform.isAndroid) ? 235 : 260
  RxDouble requestingSheetHeight = 0.0.obs; // (Platform.isAndroid) ? 195 : 220
  RxDouble tripSheetHeight = 0.0.obs; // (Platform.isAndroid) ? 275 : 300
  Rx<Address> mainPickupAddress = Address().obs;
  Rx<Address> destinationAddress = Address().obs;
  Completer<GoogleMapController> googleMapController = Completer();
  TickerProvider? vsync;
  RxDouble mapBottomPadding = 50.0.obs;
  RxBool focused = false.obs;
  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  RxSet<Polyline> polylines = <Polyline>{}.obs;
  RxSet<Marker> markers = <Marker>{}.obs;
  Set<Circle> circles = {};
  Rx<dynamic>? thisList;
  BitmapDescriptor? nearbyIcon;
  RxList<Driver> driverDetails = <Driver>[].obs;
  Rx<DirectionDetails> tripDirectionDetails = DirectionDetails().obs;
  NearbyDriver nearbyDriver = NearbyDriver();
  RxString appState = 'NORMAL'.obs;
  RxList<NearbyDriver> nearbyDriverList = <NearbyDriver>[].obs;
  RxBool drawerCanOpen = true.obs;
  String rideID = '';
  StreamSubscription<DatabaseEvent>? rideSubscription;
  Rx<GoogleMapController>? mapController;
  List<NearbyDriver> availableDrivers = <NearbyDriver>[].obs;
  Rx<LatLng>? lastMapPosition;
  RxBool nearbyDriversKeysLoaded = false.obs;
  RxString? adder;
  RxBool isRequestingLocationDetails = false.obs;
  RxBool locationOnMap = false.obs;
  RxString pinStatus = 'no pin'.obs;
  RxString distenationAdrress = ''.obs;
  RxString pickUpAdrress = ''.obs;
  @override
  Future<void> onInit() async {
    driverCarStyle = 'driversDetails';
    mainPickupAddress.value.latitude = cureentAddress.value.latitude;
    mainPickupAddress.value.longitude = cureentAddress.value.longitude;
    getAddress();
    createMarker();

    super.onInit();
  }

  CameraPosition googleCameraPosition(LatLng latLng) {
    return CameraPosition(
      target: latLng,
      zoom: 16.56,
    );
  }

  @override
  void onReady() {
    pickupController.text = homeAddress.value;
    driverAV();
    super.onReady();
  }

  void updateDriversOnMap() {
    markers.clear();
    for (NearbyDriver driver in nearbyDriverList) {
      LatLng driverPosition = LatLng(driver.latitude!, driver.longitude!);
      Marker thisMarker = Marker(
        markerId: MarkerId('driver${driver.key}'),
        position: driverPosition,
        icon: nearbyIcon!,
        rotation: HelperMethods.generateRandomNumber(360),
      );
      markers.add(thisMarker);
      markers.refresh();
    }
  }

  Future<void> getDirection() async {
    Address pickup = mainPickupAddress.value;

    Address destination = (destinationAddress.value.latitude != null)
        ? destinationAddress.value
        : mainPickupAddress.value;
    LatLng pickLatLng = LatLng(
        mainPickupAddress.value.latitude!, mainPickupAddress.value.longitude!);
    LatLng destinationLatLng =
        LatLng(destination.latitude!, destination.longitude!);

    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (BuildContext context) => ProgressDialog(
              status: 'Please wait...',
            ));

    DirectionDetails thisDetails =
        await HelperMethods.getDirectionDetails(pickLatLng, destinationLatLng);
    log(thisDetails.distanceValue.toString());
    tripDirectionDetails.value = thisDetails;

    Get.back();

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> results =
        polylinePoints.decodePolyline(thisDetails.encodedPoints!);

    polylineCoordinates.clear();
    if (results.isNotEmpty) {
      for (var point in results) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    polylines.clear();
    polylines.refresh();

    Polyline polyline = Polyline(
      polylineId: const PolylineId('polyid'),
      color: const Color.fromARGB(255, 95, 109, 237),
      points: polylineCoordinates,
      jointType: JointType.round,
      width: 4,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      geodesic: true,
    );

    polylines.add(polyline);
    polylines.refresh();
    LatLngBounds bounds;

    if (pickLatLng.latitude > destinationLatLng.latitude &&
        pickLatLng.longitude > destinationLatLng.longitude) {
      bounds =
          LatLngBounds(southwest: destinationLatLng, northeast: pickLatLng);
    } else if (pickLatLng.longitude > destinationLatLng.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(pickLatLng.latitude, destinationLatLng.longitude),
          northeast: LatLng(destinationLatLng.latitude, pickLatLng.longitude));
    } else if (pickLatLng.latitude > destinationLatLng.latitude) {
      bounds = LatLngBounds(
        southwest: LatLng(destinationLatLng.latitude, pickLatLng.longitude),
        northeast: LatLng(pickLatLng.latitude, destinationLatLng.longitude),
      );
    } else {
      bounds =
          LatLngBounds(southwest: pickLatLng, northeast: destinationLatLng);
    }

    // mapController!.value
    //     .animateCamera(CameraUpdate.newLatLngBounds(bounds, 70));

    Marker pickupMarker = Marker(
      markerId: const MarkerId('pickup'),
      position: pickLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title: pickup.placeName, snippet: 'My Location'),
    );

    Marker destinationMarker = Marker(
      markerId: const MarkerId('destination'),
      position: destinationLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow:
          InfoWindow(title: destination.placeName, snippet: 'Destination'),
    );

    markers.add(pickupMarker);
    markers.add(destinationMarker);

    Circle pickupCircle = Circle(
      circleId: const CircleId('pickup'),
      strokeColor: Colors.green,
      strokeWidth: 3,
      radius: 12,
      center: pickLatLng,
      fillColor: BrandColors.colorGreen,
    );

    Circle destinationCircle = Circle(
      circleId: const CircleId('destination'),
      strokeColor: BrandColors.colorAccentPurple,
      strokeWidth: 3,
      radius: 12,
      center: destinationLatLng,
      fillColor: BrandColors.colorAccentPurple,
    );

    circles.add(pickupCircle);
    circles.add(destinationCircle);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => const LoginPage(), binding: LogInBinding());
  }

  void showDetailSheet(String status) async {
    if (status == 'Skip') {
      destinationAddress.value = Address();
    }
    locationOnMap.value = true;
    await getDirection();
    searchSheetHeight.value = 0;
    mapBottomPadding.value = (Platform.isAndroid) ? 240 : 230;
    rideDetailsSheetHeight.value = 260;
    drawerCanOpen.value = false;
  }

  void showRequestingSheet() {
    locationOnMap.value = true;
    rideDetailsSheetHeight.value = 0;
    requestingSheetHeight.value = (Platform.isAndroid) ? 195 : 220;
    mapBottomPadding.value = (Platform.isAndroid) ? 200 : 190;
    drawerCanOpen.value = true;
    createRideRequest();
  }

  void createRideRequest() {
    DatabaseReference rideRef =
        FirebaseDatabase.instance.ref().child('rideRequest').push();
    rideID = rideRef.key.toString();
    if (Provider.of<AppData>(Get.context!, listen: false).destinationAddress ==
        null) {
      if (destinationAddress.value.latitude != null) {
        Provider.of<AppData>(Get.context!, listen: false)
            .updateDestinationAddress(destinationAddress.value);
      } else {
        Provider.of<AppData>(Get.context!, listen: false)
            .updateDestinationAddress(mainPickupAddress.value);
      }
    }
    locationOnMap.value = true;
    var pickup = mainPickupAddress.value;
    var destination = destinationAddress.value;
    Map pickupMap = {
      'latitude': pickup.latitude.toString(),
      'longitude': pickup.longitude.toString(),
    };

    Map destinationMap = {
      'latitude': destination.latitude.toString(),
      'longitude': destination.longitude.toString(),
    };

    Map rideMap = {
      'created_at': DateTime.now().toString(),
      'rider_name': appUserData.value.fullName,
      'rider_phone': appUserData.value.phoneNumber,
      'pickup_address': pickup.placeName,
      'destination_address': destination.placeName,
      'location': pickupMap,
      'destination': destinationMap,
      'payment_method': 'card',
      'driver_id': 'waiting',
      'riderID': appUserData.value.id,
    };

    rideRef.set(rideMap);
    rideSubscription = rideRef.onValue.listen((event) async {
      dynamic data = event.snapshot.value;
      //check for null snapshot
      if (event.snapshot.value == null) {
        return;
      }
      //get car details
      if (data['car_details'] != null) {
        driverCarDetails = data['car_details'].toString();
      }
      // get driver name
      if (data['driver_name'] != null) {
        driverFullName = data['driver_name'].toString();
      }
      // get driver phone number
      if (data['driver_phone'] != null) {
        driverPhoneNumber = data['driver_phone'].toString();
      }
      //get and use driver location updates
      if (data['driver_location'] != null) {
        double driverLat =
            double.parse(data['driver_location']['latitude'].toString());
        double driverLng =
            double.parse(data['driver_location']['longitude'].toString());
        LatLng driverLocation = LatLng(driverLat, driverLng);
        if (status == 'accepted') {
          updateToPickup(driverLocation);
        } else if (status == 'ontrip') {
          updateToDestination(driverLocation);
        } else if (status == 'arrived') {
          tripStatusDisplay.value = 'Driver has arrived';
        }
      }
      if (data['status'] != null) {
        status = data['status'].toString();
      }
      if (status == 'accepted') {
        showTripSheet();
        //Geofire.stopListener();
        removeGeofireMarkers();
      }
      if (status == 'ended') {
        if (data['fares'] != null) {
          int fares = int.parse(data['fares'].toString());
          log('CollectPayment');
          showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (BuildContext context) => CollectPayment(
              paymentMethod: 'cash',
              fares: fares,
            ),
          );
          tripSheetHeight.value = 0;
          rideRef.onDisconnect();
          rideSubscription!.cancel();
          rideSubscription = null;
          resetApp();
        }
      }
    });
  }

  showTripSheet() {
    requestingSheetHeight.value = 0;
    tripSheetHeight.value = (Platform.isAndroid) ? 275 : 300;
    mapBottomPadding.value = (Platform.isAndroid) ? 280 : 270;
  }

  void removeGeofireMarkers() {
    markers.removeWhere((m) => m.markerId.value.contains('driver'));
  }

  void updateToPickup(LatLng driverLocation) async {
    if (!isRequestingLocationDetails.value) {
      isRequestingLocationDetails.value = true;

      var positionLatLng =
          LatLng(currentPosition!.latitude, currentPosition!.longitude);

      var thisDetails = await HelperMethods.getDirectionDetails(
          driverLocation, positionLatLng);

      if (thisDetails == null) {
        return;
      }

      tripStatusDisplay.value =
          'Driver is Arriving - ${thisDetails.durationText}';

      isRequestingLocationDetails.value = false;
    }
  }

  void updateToDestination(LatLng driverLocation) async {
    if (!isRequestingLocationDetails.value) {
      isRequestingLocationDetails.value = true;

      var destination =
          Provider.of<AppData>(Get.context!, listen: false).destinationAddress;

      var destinationLatLng =
          LatLng(destination!.latitude!, destination.longitude!);

      var thisDetails = await HelperMethods.getDirectionDetails(
          driverLocation, destinationLatLng);

      if (thisDetails == null) {
        return;
      }

      tripStatusDisplay.value =
          'Driving to Destination - ${thisDetails.durationText}';

      isRequestingLocationDetails.value = false;
    }
  }

  void cancelRequest() {
    DatabaseReference rideRef =
        FirebaseDatabase.instance.ref().child('rideRequest');
    rideRef.remove();
    appState.value = 'NORMAL';
  }

  resetApp() {
    searchSheetHeight.value = 310;
    locationOnMap.value = false;
    polylineCoordinates.clear();
    polylines.clear();
    markers.clear();
    circles.clear();
    rideDetailsSheetHeight.value = 0;
    requestingSheetHeight.value = 0;
    tripSheetHeight.value = 0;
    tripSheetHeight.refresh();
    polylines.refresh();
    mapBottomPadding.value = (Platform.isAndroid) ? 280 : 270;
    drawerCanOpen.value = true;
    status = '';
    driverFullName = '';
    driverPhoneNumber = '';
    driverCarDetails = '';
    tripStatusDisplay.value = 'Driver is Arriving';
    polylineCoordinates.refresh();
  }

  void noDriverFound() {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) => NoDriverDialog());
  }

  void findDriver() async {
    if (nearbyDriverList.isNotEmpty) {
      DatabaseReference driverTripRef = FirebaseDatabase.instance
          .ref()
          .child('drivers/${nearbyDriverList[0].key}/newtrip');
      DatabaseReference tokenRef = FirebaseDatabase.instance
          .ref()
          .child('drivers/${nearbyDriverList[0].key}/token');
      driverTripRef.set(rideID);
      tokenRef.once().then((snapshot) {
        if (snapshot.snapshot.value != null) {
          String token = snapshot.snapshot.value.toString();
          HelperMethods.sendNotification(
              token: token, context: Get.context, rideId: rideID);
        }
        const oneSecTick = Duration(seconds: 1);
        Timer.periodic(oneSecTick, (timer) {
          // stop timer when ride request is cancelled;
          if (appState.value != 'REQUESTING') {
            driverTripRef.set('cancelled');
            driverTripRef.onDisconnect();
            timer.cancel();
            driverRequestTimeout = 30;
          }
          driverRequestTimeout--;
          // a value event listener for driver accepting trip request
          driverTripRef.onValue.listen((event) {
            // confirms that driver has clicked accepted for the new trip request
            if (event.snapshot.value.toString() == 'accepted') {
              driverTripRef.onDisconnect();
              timer.cancel();
              driverRequestTimeout = 30;
            }
          });
          if (driverRequestTimeout == 0) {
            //informs driver that ride has timed out
            driverTripRef.set('timeout');
            driverTripRef.onDisconnect();
            driverRequestTimeout = 30;
            timer.cancel();
            //select the next closest driver
            findDriver();
          }
        });
      });
    }
  }

  Future getCenter() async {
    final GoogleMapController mapController = await googleMapController.future;
    LatLng centerLatLng;
    if (pinStatus.value == 'direction location') {
      LatLngBounds visibleRegion = await mapController.getVisibleRegion();
      LatLng centerLatLng = LatLng(
        (visibleRegion.northeast.latitude + visibleRegion.southwest.latitude) /
            2,
        (visibleRegion.northeast.longitude +
                visibleRegion.southwest.longitude) /
            2,
      );
      return centerLatLng;
    } else if (pinStatus.value == 'pickup location') {
      LatLngBounds visibleRegion = await mapController.getVisibleRegion();
      centerLatLng = LatLng(
        (visibleRegion.northeast.latitude + visibleRegion.southwest.latitude) /
            2,
        (visibleRegion.northeast.longitude +
                visibleRegion.southwest.longitude) /
            2,
      );

      return centerLatLng;
    }
  }

  void createMarker() {
    if (nearbyIcon == null) {
      ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(Get.context!, size: const Size(2, 2));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration,
              (Platform.isIOS)
                  ? 'images/car_ios.png'
                  : 'images/car_android.png')
          .then((icon) {
        nearbyIcon = icon;
      });
    }
  }

  void removeFromList(String key) {
    int index = nearbyDriverList.indexWhere((element) => element.key == key);

    if (nearbyDriverList.isNotEmpty) {
      nearbyDriverList.removeAt(index);
    }
  }

  void updateNearbyLocation(NearbyDriver driver) {
    int index =
        nearbyDriverList.indexWhere((element) => element.key == driver.key);
    nearbyDriverList[index].longitude = driver.longitude;
    nearbyDriverList[index].latitude = driver.latitude;
  }

  void driverAV() {
    DatabaseReference availableDriversFromFirebase =
        FirebaseDatabase.instance.ref().child('driversAvailable');
    availableDriversFromFirebase.limitToFirst(5).once().then((snapshot) {
      Map<dynamic, dynamic> data =
          snapshot.snapshot.value as Map<dynamic, dynamic>;
      data.forEach(((key, value) {
        nearbyDriver = NearbyDriver(
            key: key,
            latitude: value['location']['lat'],
            longitude: value['location']['long']);
        nearbyDriverList.add(nearbyDriver);
        nearbyDriverList.refresh();
        // DatabaseReference userRef =
        //     FirebaseDatabase.instance.ref().child('drivers/$key');
        // Driver driver = Driver();
        // userRef.once().then((value) {
        //   dynamic data = value.snapshot.value;
        //   driver = Driver(
        //       carColor: data['carColor'],
        //       carFactory: data['carFactory'],
        //       carNumber: data['carNumber'],
        //       carType: data['carType'],
        //       driverCarBackImageUrl: data['driverCarBackImageUrl'],
        //       driverCarFrontImageUrl: data['driverCarFrontImageUrl'],
        //       driverCarLicenseImageUrl: data['driverCarLicenseImageUrl'],
        //       driverLicenseImageUrl: data['driverLicenseImageUrl'],
        //       driversIsAvailable: data['driversIsAvailable'],
        //       email: data['email'],
        //       fullname: data['fullname'],
        //       id: key,
        //       personalImageUrl: data['personalImageUrl'],
        //       phone: data['phone'],
        //       socialAgentNumber: data['socialAgentNumber'],
        //       token: data['token']);
        // });
        // driverDetails.add(driver);
      }));
    });
  }

  void getAddress() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      mainPickupAddress.value.latitude!,
      mainPickupAddress.value.longitude!,
    );
    mainPickupAddress.value.placeName = placemarks[0].name ?? '';
    homeAddress.value = placemarks[0].name ?? '';
  }
}
