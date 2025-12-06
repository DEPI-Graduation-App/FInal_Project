import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

class NotificationService extends GetxService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'news_channel',
      'News Notifications',
      channelDescription: 'Notifications for favorite news',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);
    await _notifications.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }
}
