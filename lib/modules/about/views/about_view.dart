// lib/modules/about/views/about_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('about_app'.tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Image.asset('assets/images/logo.png', height: 120),
            const SizedBox(height: 20),
            Text(
              'app_title'.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // يمكنك إضافة وصف للتطبيق في ملفات الترجمة تحت مفتاح 'about_description'
            Text('about_description'.tr, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge),
            const Divider(height: 40, thickness: 1),
            Text(
              'developed_by'.tr,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const ListTile(
              leading: Icon(Icons.person_outline),
              title: Text("اسمك الكامل هنا"), // <-- غير هذا
            ),
            const ListTile(
              leading: Icon(Icons.email_outlined),
              title: Text("your.email@example.com"), // <-- غير هذا
            ),
            const Divider(height: 40, thickness: 1),
            Center(
              child: Text('${'version'.tr}: 1.0.0', style: Theme.of(context).textTheme.bodySmall),
            ),
          ],
        ),
      ),
    );
  }
}