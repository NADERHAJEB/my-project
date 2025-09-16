// lib/modules/edit_med/views/edit_med_view.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:facebook/modules/edit_med/edit_med_controller.dart';

class EditMedView extends GetView<EditMedController> {
  const EditMedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('edit_med_title'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt_outlined),
            onPressed: controller.updateMedication,
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
                      : (controller.initialImagePath.isNotEmpty
                      ? FileImage(File(controller.initialImagePath.value))
                      : null) as ImageProvider?,
                  child: controller.imageFile.value == null && controller.initialImagePath.isEmpty
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