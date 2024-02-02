

import 'package:karaz_user/datamodels/trip_details/trip_location.dart';

class TripDetails {
    String? address;
    String? fullName;
    String? phoneNumber;
    String? imageUrlUser;
    String? userId;
    String? driverType;
    TripLocation? userPickUpLocation;
    TripLocation? userDestinationLocation;
    double? distance;
    double? expectedTimeToArrive;
    String? driverId;
    TripLocation? driverLocation;
    String? tripStatus;
    double? price;
    String? paymentMethod;

    TripDetails({
      this.address,
      this.fullName,
      this.phoneNumber,
      this.imageUrlUser,
      this.userId,
      this.userPickUpLocation,
      this.userDestinationLocation,
      this.distance,
      this.expectedTimeToArrive,
      this.driverId,
      this.driverLocation,
      this.driverType,
      this.paymentMethod,
      this.price,
      this.tripStatus,
    });

    TripDetails.fromJson(Map<String, dynamic> json) {
      driverId = json['driverId'];
      driverLocation = json['driverLocation'];
      paymentMethod = json['paymentMethod'];
      price = json['price'];
      tripStatus = json['tripStatus'];
      address = json['address'];
      fullName = json['fullName'];
      phoneNumber = json['phoneNumber'];
      imageUrlUser = json['imageUrlUser'];
      userId = json['userId'];
      userPickUpLocation = json['userPickUpLocation'] != null
          ? TripLocation.fromJson(json['userPickUpLocation'])
          : null;
      userDestinationLocation = json['userDestinationLocation'] != null
          ? TripLocation.fromJson(json['userDestinationLocation'])
          : null;
      distance = json['distance'];
      expectedTimeToArrive = json['expectedTimeToArrive'];
      driverType = json['driverType'];
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['address'] = address;
      data['fullName'] = fullName;
      data['phoneNumber'] = phoneNumber;
      data['imageUrlUser'] = imageUrlUser;
      data['userId'] = userId;
      if (userPickUpLocation != null) {
        data['userPickUpLocation'] = userPickUpLocation!.toJson();
      }
      if (userDestinationLocation != null) {
        data['userDestinationLocation'] = userDestinationLocation!.toJson();
      }
      data['distance'] = distance;
      data['expectedTimeToArrive'] = expectedTimeToArrive;
      data['driverType'] = driverType;
      data['driverId'] = driverId;
      data['paymentMethod'] = paymentMethod;
      data['price'] = price;
      data['driverLocation'] = driverLocation;
      data['tripStatus'] = tripStatus;
      return data;
    }
  }
