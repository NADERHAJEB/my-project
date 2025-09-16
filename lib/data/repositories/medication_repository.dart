import 'package:get/get.dart';
// 1. استيراد ملف قاعدة البيانات الذي أنشأناه
import 'package:facebook/core/services/database_helper.dart'; // <-- تأكد من صحة هذا المسار

class MedicationRepository {
  // 2. الحصول على نسخة من DatabaseHelper
  final DatabaseHelper _dbHelper = Get.find<DatabaseHelper>();

  // 3. تعديل دالة جلب الأدوية لتقرأ من قاعدة البيانات
  Future<List<Medicine>> getMedications() async {
    return await _dbHelper.getMedicines();
  }

  // 4. تعديل دالة إضافة دواء لتكتب في قاعدة البيانات
  Future<void> addMedication(Medicine medicine) async {
    await _dbHelper.addMedicine(medicine);
  }

  // 5. تعديل دالة حذف دواء لتحذف من قاعدة البيانات
  Future<void> deleteMedication(int id) async {
    await _dbHelper.deleteMedicine(id);
  }

  // 6. (اختياري ولكن مهم) إضافة دالة للتعديل
  Future<void> updateMedication(Medicine medicine) async {
    await _dbHelper.updateMedicine(medicine);
  }
}