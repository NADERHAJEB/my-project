
// lib/modules/add_med/views/add_med_view.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:facebook/modules/add_med/controllers/add_med_controller.dart';

class AddMedView extends GetView<AddMedController> {
  const AddMedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add_med_title'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_outlined),
            onPressed: controller.saveMedication,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Obx(() => GestureDetector(
                onTap: controller.pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: controller.imageFile.value != null
                      ? FileImage(controller.imageFile.value!)
                      : null,
                  child: controller.imageFile.value == null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.camera_alt_outlined, size: 40),
                      Text('pick_image_button'.tr, style: const TextStyle(fontSize: 12)),
                    ],
                  )
                      : null,
                ),
              )),
              const SizedBox(height: 24),
              TextFormField(
                controller: controller.nameController,
                decoration: InputDecoration(labelText: 'med_name_label'.tr),
                validator: (value) => (value?.isEmpty ?? true) ? 'required_field'.tr : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.doseController,
                decoration: InputDecoration(labelText: 'dosage_label'.tr),
                validator: (value) => (value?.isEmpty ?? true) ? 'required_field'.tr : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.timeController,
                decoration: InputDecoration(
                  labelText: 'reminder_times'.tr,
                  suffixIcon: const Icon(Icons.access_time_outlined),
                ),
                readOnly: true,
                onTap: () => controller.selectTime(context),
                validator: (value) => (value?.isEmpty ?? true) ? 'required_field'.tr : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
