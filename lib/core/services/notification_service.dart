
// lib/core/services/notification_service.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:facebook/core/services/database_helper.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService extends GetxService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<NotificationService> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    await _requestPermissions();
    return this;
  }

  Future<void> _requestPermissions() async {
    // طلب صلاحيات أندرويد
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    if (androidImplementation != null) {
      // طلب صلاحية عرض الإشعارات (لأندرويد 13+)
      await androidImplementation.requestNotificationsPermission();

      // طلب صلاحية الإنذارات الدقيقة (لأندرويد 12+، وهذا هو الحل للخطأ الأخير)
      await androidImplementation.requestExactAlarmsPermission();
    }

    // طلب صلاحيات iOS
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> scheduleNotification(Medicine medication) async {
    const soundName = 'notification_sound';

    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'med_guide_channel_id',
      'Medication Reminders',
      channelDescription: 'Channel for medication reminder notifications',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      playSound: true,
      sound: RawResourceAndroidNotificationSound(soundName),
    );

    const DarwinNotificationDetails darwinPlatformChannelSpecifics = DarwinNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true, sound: '$soundName.aiff');

    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: darwinPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      medication.id!,
      'حان وقت دوائك: ${medication.name}',
      'لا تنسى أخذ جرعة: ${medication.dose}',
      tz.TZDateTime.from(medication.time, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}