
// lib/modules/home/views/home_view.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:facebook/modules/home/controllers/home_controller.dart';
import 'package:facebook/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home_title'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Get.toNamed(Routes.SETTINGS),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.medications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.medical_services_outlined, size: 80, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text('no_meds_title'.tr, style: Theme.of(context).textTheme.headlineSmall),
                Text('no_meds_subtitle'.tr, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: controller.medications.length,
          itemBuilder: (context, index) {
            final med = controller.medications[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: ListTile(
                onTap: () => Get.toNamed(Routes.EDIT_MED, arguments: med),
                leading: med.imagePath != null && med.imagePath!.isNotEmpty
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(File(med.imagePath!), width: 50, height: 50, fit: BoxFit.cover),
                )
                    : CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                  child: const Icon(Icons.medication_liquid_outlined),
                ),
                title: Text(med.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${'dosage_label'.tr}: ${med.dose}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateFormat.jm(Get.locale?.languageCode).format(med.time),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                      onPressed: () {
                        Get.defaultDialog(
                          title: 'delete_confirmation_title'.tr,
                          middleText: 'delete_confirmation_body'.tr,
                          textConfirm: 'delete'.tr,
                          textCancel: 'cancel'.tr,
                          confirmTextColor: Colors.white,
                          onConfirm: () {
                            controller.deleteMedication(med.id!);
                            Get.back();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_MED),
        child: const Icon(Icons.add),
      ),
    );
  }
}