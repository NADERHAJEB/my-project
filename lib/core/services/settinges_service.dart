


// lib/core/services/settinges_service.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService extends GetxService {
  late SharedPreferences _prefs;
  final themeMode = ThemeMode.system.obs;
  final locale = Get.deviceLocale.obs;

  Future<SettingsService> init() async {
    _prefs = await SharedPreferences.getInstance();
    _loadSettings();
    return this;
  }

  void _loadSettings() {
    final theme = _prefs.getString('theme') ?? 'system';
    switch (theme) {
      case 'light':
        themeMode.value = ThemeMode.light;
        break;
      case 'dark':
        themeMode.value = ThemeMode.dark;
        break;
      default:
        themeMode.value = ThemeMode.system;
    }

    final langCode = _prefs.getString('language_code');
    if (langCode != null) {
      locale.value = Locale(langCode);
    }
  }

  void changeTheme(ThemeMode mode) {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
    String theme;
    switch (mode) {
      case ThemeMode.light:
        theme = 'light';
        break;
      case ThemeMode.dark:
        theme = 'dark';
        break;
      default:
        theme = 'system';
    }
    _prefs.setString('theme', theme);
  }

  void changeLanguage(String langCode) {
    locale.value = Locale(langCode);
    Get.updateLocale(Locale(langCode));
    _prefs.setString('language_code', langCode);
  }
}