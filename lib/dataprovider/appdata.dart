import 'package:flutter/cupertino.dart';
import 'package:karaz_user/datamodels/address.dart';

class AppData extends ChangeNotifier {
  Address? pickupAddress;

  Address? destinationAddress;

  void updatePickupAddress(Address pickup) {
    pickupAddress = pickup;
    notifyListeners();
  }

  void updateDestinationAddress(Address destination) {
    destinationAddress = destination;
    notifyListeners();
  }
}
