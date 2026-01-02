import 'package:dailies_v2/models/stamina.dart';
import 'package:dailies_v2/utils/result.dart';
import 'package:dailies_v2/utils/utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

const double NOTIFICATION_ENERGY_THRESHOLD = 0.9;

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  Future<Result<void>> scheduleGachaNotification(StaminaModel stamina) async {
    if (stamina.id == null)
      return Result.error(
        NotificationSchedulingFailure('Stamina id must not be null'),
      );

    await plugin.cancel(stamina.id!);

    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'gacha_channel',
        'Gacha Alerts',
        channelDescription: 'Notifies when gacha energy is almost full',
        importance: Importance.high,
        priority: Priority.high,
      ),
    );

    final String title = '${stamina.gachaTitle} energy almost full';
    final String body =
        'Energy at ${(stamina.maxStamina * NOTIFICATION_ENERGY_THRESHOLD).ceil()}/${stamina.maxStamina}';
    final Result<DateTime> result = predictGachaNotificationTime(
      stamina: stamina,
    );

    switch (result) {
      case Ok<DateTime>(value: final DateTime notificationTime):
        await plugin.zonedSchedule(
          stamina.id!,
          title,
          body,
          tz.TZDateTime.from(notificationTime, tz.local),
          notificationDetails,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        );
        return Result.ok(null);

      case Error<DateTime>(failure: final Failure failure):
        return Result.error(failure);
    }
  }

  Future<void> initialize() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings = InitializationSettings(android: androidInit);

    await plugin.initialize(initializationSettings);

    await plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    await plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestExactAlarmsPermission();
  }
}

final LocalNotificationService LOCAL_NOTIFICATION_SERVICE =
    LocalNotificationService();
