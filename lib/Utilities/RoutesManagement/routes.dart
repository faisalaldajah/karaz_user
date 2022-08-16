// ignore_for_file: constant_identifier_names

part of 'pages.dart';

abstract class Routes {
  // Common
  static const START_PAGE = '/startPage';
  static const ON_BOARD = '/onBorad';
  static const WELCOME = '/welcome';
  static const SIGN_IN = '/signin';
  static const SIGN_UP = '/signup';
  static const DASHBOARD = '/dashboard';

  // Stores
  static const STORES_HOME = '/storesHome';

  // Delivery
  static const DELIVERY_HUB = '/deliveryHub';
  static const DELIVERY_HOME = '/deliveryHome';
  static const DELIVERY_STORES = '/deliveryStores';
  static const DELIVERY_STORE_DETAILS = '/deliveryStoreDetails';
  static const DELIVERY_STORE_NEW_ORDER = '/deliveryNewOrder';
  static const DELIVERY_REGISTRATION_DRIVER = '/deliveryRegistrationDriver';
  static const DELIVERY_ADDRESS_BOOK = '/deliveryAddressBook';
  static const DELIVERY_NEW_ADDRESS = '/deliveryAddNewAddress';
  static const DELIVERY_NEW_ADDRESS_DETAILS = '/deliveryAddNewAddressDetails';
  static const DELIVRY_CHAT = '/deliveryChat';
  static const DELIVERY_STORES_SEARCH = '/deliveryStoresSearch';
  static const DELIVERY_MY_ORDER = '/myOrder';
  static const DELIVERY_ORDER_OFFERS = '/oderOffers';
  static const DELIVERY_CART = '/deliveryCart';
}
