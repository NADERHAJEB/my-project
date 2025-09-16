
// lib/modules/edit_med/controllers/edit_med_controller.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:facebook/core/services/database_helper.dart';
import 'package:facebook/core/services/notification_service.dart';
import 'package:facebook/modules/home/controllers/home_controller.dart';

class EditMedController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final doseController = TextEditingController();
  final timeController = TextEditingController();

  final NotificationService _notificationService = Get.find<NotificationService>();
  final DatabaseHelper _dbHelper = Get.find<DatabaseHelper>();

  late final Medicine _originalMedicine;

  var imageFile = Rx<File?>(null);
  var initialImagePath = ''.obs;
  DateTime? selectedTime;

  @override
  void onInit() {
    super.onInit();
    _originalMedicine = Get.arguments as Medicine;

    nameController.text = _originalMedicine.name;
    doseController.text = _originalMedicine.dose;
    selectedTime = _originalMedicine.time;
    timeController.text = DateFormat.jm(Get.locale?.languageCode).format(selectedTime!);
    if (_originalMedicine.imagePath != null) {
      initialImagePath.value = _originalMedicine.imagePath!;
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(selectedTime!));
    if (picked != null) {
      final now = DateTime.now();
      selectedTime = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      timeController.text = DateFormat.jm(Get.locale?.languageCode).format(selectedTime!);
    }
  }

  Future<void> updateMedication() async {
    if (formKey.currentState!.validate()) {
      final updatedMedicine = Medicine(
        id: _originalMedicine.id,
        name: nameController.text,
        dose: doseController.text,
        time: selectedTime!,
        imagePath: imageFile.value?.path ?? initialImagePath.value,
      );

      await _dbHelper.updateMedicine(updatedMedicine);
      await _notificationService.cancelNotification(_originalMedicine.id!);
      await _notificationService.scheduleNotification(updatedMedicine);

      Get.find<HomeController>().fetchMedications();
      Get.back();
      Get.snackbar("تم التحديث", "تم تحديث بيانات الدواء بنجاح.", snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    doseController.dispose();
    timeController.dispose();
    super.onClose();
  }
}
