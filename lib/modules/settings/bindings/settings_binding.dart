// lib/modules/settings/bindings/settings_binding.dart
import 'package:get/get.dart';
import 'package:facebook/modules/settings/controllers/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}