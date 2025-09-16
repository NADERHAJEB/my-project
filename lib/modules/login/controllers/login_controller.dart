
// lib/modules/login/controllers/login_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    if (loginFormKey.currentState!.validate()) {
      const correctUsername = "admin";
      const correctPassword = "123";

      if (usernameController.text == correctUsername && passwordController.text == correctPassword) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar(
          'login_failed'.tr,
          'invalid_credentials'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
