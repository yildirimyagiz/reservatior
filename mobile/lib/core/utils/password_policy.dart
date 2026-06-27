import 'package:easy_localization/easy_localization.dart';
class PasswordPolicy {
  static bool isStrongPassword(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    if (!password.contains(RegExp(r'[a-z]'))) return false;
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
    return true;
  }

  static String getStrengthMessage(String password) {
    if (password.length < 8) return 'mobile.leftovers.password_must_be_at_least_8_characters_l'.tr();
    if (!password.contains(RegExp(r'[A-Z]'))) return 'mobile.leftovers.include_at_least_one_uppercase_letter'.tr();
    if (!password.contains(RegExp(r'[a-z]'))) return 'mobile.leftovers.include_at_least_one_lowercase_letter'.tr();
    if (!password.contains(RegExp(r'[0-9]'))) return 'mobile.leftovers.include_at_least_one_number'.tr();
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return 'mobile.leftovers.include_at_least_one_special_character'.tr();
    return '';
  }
}
