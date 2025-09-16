
// lib/modules/settings/controllers/settings_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:facebook/core/services/settinges_service.dart';

class SettingsController extends GetxController {
  final SettingsService _settingsService = Get.find<SettingsService>();

  Rx<ThemeMode> get currentTheme => _settingsService.themeMode;
  Rx<Locale?> get currentLocale => _settingsService.locale;

  void changeTheme(ThemeMode? mode) {
    if (mode != null) {
      _settingsService.changeTheme(mode);
    }
  }

  void changeLanguage(String? langCode) {
    if (langCode != null) {
      _settingsService.changeLanguage(langCode);
    }
  }
}