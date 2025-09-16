
// lib/modules/home/controllers/home_controller.dart
import 'package:get/get.dart';
import 'package:facebook/core/services/database_helper.dart';
import 'package:facebook/core/services/notification_service.dart';

class HomeController extends GetxController {
  final DatabaseHelper _dbHelper = Get.find<DatabaseHelper>();
  final NotificationService _notificationService = Get.find<NotificationService>();

  var medications = <Medicine>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMedications();
  }

  void fetchMedications() async {
    try {
      isLoading(true);
      medications.value = await _dbHelper.getMedicines();
    } finally {
      isLoading(false);
    }
  }

  void deleteMedication(int id) async {
    await _dbHelper.deleteMedicine(id);
    await _notificationService.cancelNotification(id);
    fetchMedications();
    Get.snackbar("تم الحذف", "تم حذف الدواء وإلغاء تذكيره.", snackPosition: SnackPosition.BOTTOM);
  }
}
