// lib/modules/add_med/controllers/add_med_controller.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:facebook/core/services/database_helper.dart';
import 'package:facebook/core/services/notification_service.dart';
import 'package:facebook/modules/home/controllers/home_controller.dart';

class AddMedController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final doseController = TextEditingController();
  final timeController = TextEditingController();

  final NotificationService _notificationService = Get.find<NotificationService>();
  final DatabaseHelper _dbHelper = Get.find<DatabaseHelper>();

  var imageFile = Rx<File?>(null);
  DateTime? selectedTime;

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) {
      final now = DateTime.now();
      selectedTime = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      timeController.text = DateFormat.jm(Get.locale?.languageCode).format(selectedTime!);
    }
  }

  Future<void> saveMedication() async {
    if (formKey.currentState!.validate()) {
      if (selectedTime == null) {
        Get.snackbar('خطأ', 'الرجاء تحديد وقت التذكير', snackPosition: SnackPosition.BOTTOM);
        return;
      }

      final newMedicine = Medicine(
        name: nameController.text,
        dose: doseController.text,
        time: selectedTime!,
        imagePath: imageFile.value?.path,
      );

      final savedMedicine = await _dbHelper.addMedicine(newMedicine);
      await _notificationService.scheduleNotification(savedMedicine);

      Get.find<HomeController>().fetchMedications();
      Get.back();
      Get.snackbar("تم بنجاح", "تم حفظ الدواء وجدولة الإشعار.", snackPosition: SnackPosition.BOTTOM);
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
