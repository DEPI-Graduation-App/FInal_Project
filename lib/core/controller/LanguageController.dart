import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final _storage = GetStorage();
  final _key = 'language_code';

  // Get the current locale from storage or default to device locale
  Locale get initialLocale {
    final savedCode = _storage.read<String>(_key);
    if (savedCode != null) {
      return Locale(savedCode);
    }
    // Default to device locale if supported, otherwise English
    final deviceLocale = Get.deviceLocale;
    if (deviceLocale != null &&
        ['en', 'ar'].contains(deviceLocale.languageCode)) {
      return deviceLocale;
    }
    return const Locale('en');
  }

  // Change language and save preference
  void changeLanguage(String languageCode) {
    final locale = Locale(languageCode);
    Get.updateLocale(locale);
    _storage.write(_key, languageCode);
  }

  // Check if current language is Arabic
  bool get isArabic => Get.locale?.languageCode == 'ar';
}
