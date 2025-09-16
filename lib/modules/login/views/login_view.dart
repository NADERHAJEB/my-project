// lib/modules/login/views/login_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:facebook/modules/login/controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginController());

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 120),
              const SizedBox(height: 20),
              Text('welcome_back'.tr, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text('login_to_continue'.tr, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 40),
              Form(
                key: controller.loginFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.usernameController,
                      decoration: InputDecoration(
                        labelText: 'username'.tr,
                        prefixIcon: const Icon(Icons.person_outline),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) => (value?.isEmpty ?? true) ? 'username_required'.tr : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controller.passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'password'.tr,
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) => (value?.isEmpty ?? true) ? 'password_required'.tr : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                  onPressed: controller.login,
                  child: Text('login'.tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
