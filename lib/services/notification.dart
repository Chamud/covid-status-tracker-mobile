import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationAPI {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
          importance: Importance.max, icon: 'app_icon'),
      iOS: IOSNotificationDetails(),
    );
  }

  Future symptomNotification({int id = 1}) async {
    _notifications.zonedSchedule(
        id,
        "Symptom Tracker",
        "It's time to add daily symptom data!",
        nextInstanceOfTenAM(),
        await _notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  Future<void> cancelsymptomNotification() async {
    await _notifications.cancel(1);
  }

  tz.TZDateTime nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  static Future mapNotification({int id = 2, String? body}) async =>
      _notifications.show(
        id,
        "Covid Map: Critical Area Alert",
        body,
        await _notificationDetails(),
      );
}
