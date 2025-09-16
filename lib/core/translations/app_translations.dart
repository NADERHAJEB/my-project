
// lib/core/translations/app_translations.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppTranslations extends Translations {
  Map<String, Map<String, String>> _translations = {};

  Future<void> loadTranslations() async {
    final arString = await rootBundle.loadString('assets/locales/ar.json');
    final enString = await rootBundle.loadString('assets/locales/en.json');

    _translations = {
      'ar': Map<String, String>.from(json.decode(arString)),
      'en': Map<String, String>.from(json.decode(enString)),
    };
  }

  @override
  Map<String, Map<String, String>> get keys => _translations;
}
