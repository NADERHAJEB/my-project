// lib/main.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart'; // <-- تأكد من وجود هذا الاستيراد

import 'package:facebook/core/services/database_helper.dart';
import 'package:facebook/core/services/settinges_service.dart';
import 'package:facebook/core/services/notification_service.dart';
import 'package:facebook/core/theme/app_theme.dart';
import 'package:facebook/core/translations/app_translations.dart';
import 'package:facebook/routes/app_pages.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  // 1. تهيئة Flutter
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  // 3. تهيئة باقي الخدمات
  await Get.putAsync(() => DatabaseHelper().init());
  await Get.putAsync(() => SettingsService().init());
  await Get.putAsync(() => NotificationService().init());

  // 4. تهيئة المناطق الزمنية
  tz.initializeTimeZones();

  // 5. تحميل ملفات الترجمة
  final translations = AppTranslations();
  await translations.loadTranslations();

  // 6. تشغيل التطبيق
  runApp(MyApp(translations: translations));
}

class MyApp extends StatelessWidget {
  final AppTranslations translations;
  const MyApp({super.key, required this.translations});

  @override
  Widget build(BuildContext context) {
    final settingsService = Get.find<SettingsService>();

    return Obx(() => GetMaterialApp(
      title: 'مرشد الأدوية',
      debugShowCheckedModeBanner: false,
      translations: translations,
      locale: settingsService.locale.value,
      fallbackLocale: const Locale('en'),
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: settingsService.themeMode.value,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ));
  }
}