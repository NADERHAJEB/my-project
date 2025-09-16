
// lib/routes/app_pages.dart
import 'package:get/get.dart';
import 'package:facebook/modules/add_med/bindings/add_med_binding.dart';
import 'package:facebook/modules/add_med/views/add_med_view.dart';
import 'package:facebook/modules/home/bindings/home_binding.dart';
import 'package:facebook/modules/home/views/home_view.dart';
import 'package:facebook/modules/settings/bindings/settings_binding.dart';
import 'package:facebook/modules/settings/views/settings_view.dart';
import 'package:facebook/modules/about/views/about_view.dart';
import 'package:facebook/modules/login/views/login_view.dart';
import 'package:facebook/modules/edit_med/edit_med_view.dart';
import 'package:facebook/modules/edit_med/edit_med_controller.dart';

import '../modules/edit_med/edit_med_controller.dart';
import '../modules/edit_med/edit_med_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(name: _Paths.HOME, page: () => const HomeView(), binding: HomeBinding()),
    GetPage(name: _Paths.ADD_MED, page: () => const AddMedView(), binding: AddMedBinding(), fullscreenDialog: true),
    GetPage(name: _Paths.SETTINGS, page: () => const SettingsView(), binding: SettingsBinding()),
    GetPage(name: _Paths.LOGIN, page: () => const LoginView()),
    GetPage(name: _Paths.ABOUT, page: () => const AboutView()),
    GetPage(
      name: _Paths.EDIT_MED,
      page: () => const EditMedView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<EditMedController>(() => EditMedController());
      }),
      fullscreenDialog: true,
    ),
  ];
}
