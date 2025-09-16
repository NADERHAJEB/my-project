
// lib/modules/settings/views/settings_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:facebook/modules/settings/controllers/settings_controller.dart';
import '../../../routes/app_pages.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings_title'.tr),
      ),
      body: Obx(
            () => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ListTile(
              leading: const Icon(Icons.language_outlined),
              title: Text('language'.tr),
            ),
            RadioListTile<String>(
              title: const Text('العربية'),
              value: 'ar',
              groupValue: controller.currentLocale.value?.languageCode,
              onChanged: controller.changeLanguage,
            ),
            RadioListTile<String>(
              title: const Text('English'),
              value: 'en',
              groupValue: controller.currentLocale.value?.languageCode,
              onChanged: controller.changeLanguage,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.brightness_6_outlined),
              title: Text('theme'.tr),
            ),
            RadioListTile<ThemeMode>(
              title: Text('light_theme'.tr),
              value: ThemeMode.light,
              groupValue: controller.currentTheme.value,
              onChanged: controller.changeTheme,
            ),
            RadioListTile<ThemeMode>(
              title: Text('dark_theme'.tr),
              value: ThemeMode.dark,
              groupValue: controller.currentTheme.value,
              onChanged: controller.changeTheme,
            ),
            RadioListTile<ThemeMode>(
              title: Text('system_theme'.tr),
              value: ThemeMode.system,
              groupValue: controller.currentTheme.value,
              onChanged: controller.changeTheme,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text('about_app'.tr),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Get.toNamed(Routes.ABOUT),
            ),
          ],
        ),
      ),
    );
  }
}