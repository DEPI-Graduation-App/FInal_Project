import 'dart:ui';
import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  /// Initialize once
  static Future<void> initializeNotifications() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'news_channel',
          channelName: 'News Alerts',
          channelDescription: 'Notifications for favorite categories',
          importance: NotificationImportance.Max,
          defaultColor: const Color(0xFF005DAA),
          ledColor: const Color(0xFFFFFFFF),
        )
      ],
      debug: false,
    );
  }

  /// Request permissions
  static Future<void> requestPermissions() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  /// Show local notification
  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        channelKey: 'news_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }
}
