import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  /// Singleton instance
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  /// Initialize once from main.dart
  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
    InitializationSettings(android: androidSettings);

    await notificationsPlugin.initialize(initSettings);
  }

  /// Ask the user for permission (only Android)
  static Future<void> requestPermissions() async {
    final androidSpecific =
    notificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    if (androidSpecific != null) {
      await androidSpecific.requestNotificationsPermission();
    }
  }

  /// Show a notification
  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'news_channel',
      'News Notifications',
      channelDescription: 'Notifications for favorite categories',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidDetails);

    await notificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }
}
