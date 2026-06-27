import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AppFormatters {
  static String getCurrencyCode(BuildContext context) {
    final langCode = context.locale.languageCode;
    switch (langCode) {
      case 'tr': return 'TRY';
      case 'en': return 'USD';
      case 'de':
      case 'fr':
      case 'es':
      case 'it':
      case 'fi':
      case 'gr':
        return 'EUR';
      case 'ar': return 'SAR';
      case 'zh': return 'CNY';
      case 'ja': return 'JPY';
      case 'pt': return 'BRL'; // or EUR depending on pt-BR vs pt-PT, default BRL for now
      case 'hi': return 'INR';
      case 'ko': return 'KRW';
      case 'ru': return 'RUB';
      case 'nl': return 'EUR';
      case 'se': return 'SEK';
      case 'no': return 'NOK';
      case 'da': return 'DKK';
      case 'pl': return 'PLN';
      default: return 'USD';
    }
  }

  static String formatPrice(BuildContext context, double? amount) {
    if (amount == null) return NumberFormat.simpleCurrency(name: getCurrencyCode(context), decimalDigits: 0).format(0);
    
    final currencyCode = getCurrencyCode(context);
    
    // For very large numbers in property listings, we might want to abbreviate (e.g. 28.5M) 
    // but for now let's use the standard locale-aware currency formatter.
    if (amount >= 1000000) {
      final millions = amount / 1000000;
      final symbol = NumberFormat.simpleCurrency(name: currencyCode).currencySymbol;
      return '$symbol${millions.toStringAsFixed(1)}M';
    }
    
    final formatter = NumberFormat.simpleCurrency(name: currencyCode, decimalDigits: 0);
    return formatter.format(amount);
  }

  static String formatArea(BuildContext context, double? sqm) {
    if (sqm == null) return 'mobile.leftovers.0_m'.tr();
    
    final langCode = context.locale.languageCode;
    
    // US uses sqft
    if (langCode == 'en') {
      final sqft = sqm * 10.7639;
      return '${NumberFormat('#,##0', context.locale.toString()).format(sqft)} sqft';
    }
    
    // Rest of world uses sqm
    return '${NumberFormat('#,##0', context.locale.toString()).format(sqm)} m²';
  }
}
