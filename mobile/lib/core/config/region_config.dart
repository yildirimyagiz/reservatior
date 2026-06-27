class RegionalConfig {
  final String countryCode;
  final String countryName;
  final String currency;
  final String currencySymbol;
  final String phoneCode;
  final String languageCode;
  final List<String> supportedLanguages;
  final double taxRate;
  final String taxName;
  final double baseCommission;
  final int maxLeasePeriodMonths;
  final AddressFormat addressFormat;
  final AiServices aiServices;

  RegionalConfig({
    required this.countryCode,
    required this.countryName,
    required this.currency,
    required this.currencySymbol,
    required this.phoneCode,
    required this.languageCode,
    required this.supportedLanguages,
    required this.taxRate,
    required this.taxName,
    required this.baseCommission,
    required this.maxLeasePeriodMonths,
    required this.addressFormat,
    required this.aiServices,
  });

  factory RegionalConfig.fromJson(Map<String, dynamic> json) {
    return RegionalConfig(
      countryCode: json['countryCode'],
      countryName: json['countryName'],
      currency: json['currency'],
      currencySymbol: json['currencySymbol'],
      phoneCode: json['phoneCode'],
      languageCode: json['languageCode'],
      supportedLanguages: List<String>.from(json['supportedLanguages']),
      taxRate: (json['taxRate'] as num).toDouble(),
      taxName: json['taxName'],
      baseCommission: (json['baseCommission'] as num).toDouble(),
      maxLeasePeriodMonths: json['maxLeasePeriodMonths'],
      addressFormat: AddressFormat.fromJson(json['addressFormat']),
      aiServices: AiServices.fromJson(json['aiServices']),
    );
  }
}

class AddressFormat {
  final String adminLevel1;
  final String adminLevel2;
  final bool zipCodeRequired;

  AddressFormat({
    required this.adminLevel1,
    required this.adminLevel2,
    required this.zipCodeRequired,
  });

  factory AddressFormat.fromJson(Map<String, dynamic> json) {
    return AddressFormat(
      adminLevel1: json['adminLevel1'],
      adminLevel2: json['adminLevel2'],
      zipCodeRequired: json['zipCodeRequired'],
    );
  }
}

class AiServices {
  final bool videoGenEnabled;
  final bool brochureGenEnabled;
  final bool legalReviewEnabled;

  AiServices({
    required this.videoGenEnabled,
    required this.brochureGenEnabled,
    required this.legalReviewEnabled,
  });

  factory AiServices.fromJson(Map<String, dynamic> json) {
    return AiServices(
      videoGenEnabled: json['videoGenEnabled'],
      brochureGenEnabled: json['brochureGenEnabled'],
      legalReviewEnabled: json['legalReviewEnabled'],
    );
  }
}
