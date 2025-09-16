// lib/modules/add_med/bindings/add_med_binding.dart
import 'package:get/get.dart';
import 'package:facebook/modules/add_med/controllers/add_med_controller.dart';

class AddMedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddMedController>(() => AddMedController());
  }
}
