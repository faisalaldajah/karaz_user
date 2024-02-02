class RegExption {
  static const String arabicAndEnglish = '[ a-zA-Zا-ي]';
  static const String noNumber = '[a-zA-Zا-ي?=.*!@#\$%^&*(),.?:{}|<>]';
  static const String onlyNumber = '[0-9]';
  static const String phoneVal = r'^(?:[+0]9)?[0-9]{10}$';
  static const String passwordPattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  static const String email =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static const String emailVal =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const String upercase = r'[a-z]';
  static const String lowercase = r'[a-z]';
  static const String passwordValedate = '[a-zA-Z?=.*!@#\$%^&*(),.?:{}|<>0-9]';
}
