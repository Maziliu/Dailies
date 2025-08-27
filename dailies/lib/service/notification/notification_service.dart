import 'package:dailies/common/utils/ui_helpers.dart';
import 'package:dailies/data/models/stamina.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart';
import 'package:timezone/timezone.dart';

class NotificationService {
  final _notificationPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  bool get isInitialied => _isInitialized;

  Future<void> initialize() async {
    if (_isInitialized) return;
    initializeTimeZones();
    setLocalLocation(getLocation(await FlutterTimezone.getLocalTimezone()));

    await _notificationPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

    const androidInitializeSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    await _notificationPlugin.initialize(const InitializationSettings(android: androidInitializeSettings));

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'Dailies',
      'Dailies Notifications',
      description: 'Notifications for Dailies',
      importance: Importance.max,
    );

    await _notificationPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    _isInitialized = true;
  }

  NotificationDetails _configureNotificationDetails() {
    const androidDetails = AndroidNotificationDetails(
      'Dailies',
      'Dailies Notifications',
      channelDescription: 'Notifications for Dailies',
      importance: Importance.max,
      priority: Priority.high,
    );

    return const NotificationDetails(android: androidDetails);
  }

  Future<void> scheduleGachaTimerNotification(Stamina stamina, DateTime scheduledTime, int projectedStamina) async {
    final NotificationDetails notificationDetails = _configureNotificationDetails();
    final String title = formatTitle(stamina.gachaTitle);
    final String body = ' ${formatAssetName(stamina.imageName ?? '')} $projectedStamina/${stamina.maxStamina}';

    // await _notificationPlugin.show(stamina.id, title, body, notificationDetails);

    print(DateTime.now().difference(scheduledTime).inSeconds);

    await _notificationPlugin.zonedSchedule(
      stamina.id,
      title,
      body,
      TZDateTime.from(scheduledTime, local),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> cancelScheduledNotification(int id) async => await _notificationPlugin.cancel(id);
}
