class CountryCode {
  const CountryCode({
    required this.name,
    required this.flag,
    required this.code,
    required this.dialCode,
    required this.nameTranslations,
    required this.minLength,
    required this.maxLength,
    this.regionCode = '',
  });
  final String name;
  final Map<String, String> nameTranslations;
  final String flag;
  final String code;
  final String dialCode;
  final String regionCode;
  final int minLength;
  final int maxLength;

  String get fullCountryCode => dialCode + regionCode;

  String get displayCC {
    if (regionCode != '') {
      return '$dialCode $regionCode';
    }
    return dialCode;
  }

  String localizedName(String languageCode) =>
      nameTranslations[languageCode] ?? name;
}
