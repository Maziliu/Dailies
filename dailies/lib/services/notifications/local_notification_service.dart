import 'package:dailies_v2/models/stamina.dart';
import 'package:dailies_v2/utils/result.dart';
import 'package:dailies_v2/utils/utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

const double NOTIFICATION_ENERGY_THRESHOLD = 0.98;

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  Future<Result<void>> scheduleGachaNotification(StaminaModel stamina) async {
    if (stamina.id == null)
      return Result.error(
        NotificationSchedulingFailure('Stamina id must not be null'),
      );

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
        'Energy at ${stamina.currentStamina}/${stamina.maxStamina}';
    final Result<DateTime> result = predictGachaNotificationTime(
      stamina: stamina,
      threshold: NOTIFICATION_ENERGY_THRESHOLD,
    );

    switch (result) {
      case Ok<DateTime>(value: final DateTime notificationTime):
        final DateTime now = DateTime.now();
        final scheduledAt = notificationTime.isAfter(now)
            ? notificationTime
            : now.add(const Duration(seconds: 1));

        return await guardedAsyncExecute(
          () => plugin.zonedSchedule(
            stamina.id!,
            title,
            body,
            tz.TZDateTime.from(scheduledAt, tz.local),
            notificationDetails,
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          ),
          NotificationSchedulingFailure('Failed to schedule notification'),
        );

      case Error<DateTime>(failure: final Failure failure):
        return Result.error(failure);
    }
  }

  Future<Result<void>> rescheduleGachaNotification(StaminaModel stamina) async {
    final Result<void> descheduleResult = await descheduleNotification(
      stamina.id,
    );

    switch (descheduleResult) {
      case Error<void>(failure: final Failure failure):
        return Result.error(failure);
      case Ok<void>():
    }

    final Result<void> rescheduleResult = await scheduleGachaNotification(
      stamina,
    );

    switch (rescheduleResult) {
      case Error<void>(failure: final Failure failure):
        return Result.error(failure);
      case Ok<void>():
    }

    return Result.ok(null);
  }

  Future<Result<void>> descheduleNotification(int? notificationId) async {
    if (notificationId == null)
      return Result.error(
        NotificationSchedulingFailure('Cannot deschedule null notification id'),
      );

    if (notificationId < 0)
      return Result.error(
        NotificationSchedulingFailure(
          'Cannot deschedule notification id $notificationId. Must be > 0',
        ),
      );

    await plugin.cancel(notificationId);

    return Result.ok(null);
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
