// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_timezone/flutter_timezone.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
//
// class LocalNotificationsService {
//   LocalNotificationsService._();
//   static final LocalNotificationsService _instance =
//       LocalNotificationsService._();
//   static LocalNotificationsService get instance => _instance;
//
//   FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin =>
//       FlutterLocalNotificationsPlugin();
//
//   static StreamController<NotificationResponse> get streamCtrl =>
//       StreamController();
//
//   static const String channelId = "normal_channel_id";
//   static const String channelName = "Normal Channel";
//   static const String channelDescription = "Receiving All Normal Notifications";
//
//   static const int basicNotificationId = 0;
//   static const int repeatedNotificationId = 1;
//   static const int scheduledNotificationId = 2;
//
//   static onTap(NotificationResponse notRes) {
//     streamCtrl.add(notRes);
//   }
//
//   /// Initialize Notifications
//   Future<void> initializeNotification() async {
//     try {
//       const AndroidInitializationSettings initializationSettingsAndroid =
//           AndroidInitializationSettings('@mipmap/ic_launcher');
//
//       const DarwinInitializationSettings initializationSettingsIOS =
//           DarwinInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//         requestSoundPermission: true,
//       );
//
//       const InitializationSettings initializationSettings =
//           InitializationSettings(
//         android: initializationSettingsAndroid,
//         iOS: initializationSettingsIOS,
//       );
//
//       // Create the notification channel
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>()
//           ?.requestNotificationsPermission();
//
//       await flutterLocalNotificationsPlugin.initialize(
//         initializationSettings,
//         onDidReceiveNotificationResponse: onTap,
//         onDidReceiveBackgroundNotificationResponse: onTap,
//       );
//
//       debugPrint("Notification Initialized Successfully!");
//     } catch (e, stackTrace) {
//       debugPrint("Error Initializing Notifications: $e");
//       debugPrint("Stack trace: $stackTrace");
//     }
//   }
//
//   Future<void> showBasicNotification() async {
//     try {
//       /// Define Android notification details
//       final AndroidNotificationDetails androidNotificationDetails =
//           AndroidNotificationDetails(
//         channelId,
//         channelName,
//         channelDescription: channelDescription,
//         importance: Importance.max,
//         priority: Priority.high,
//         playSound: true,
//         enableVibration: true,
//         showWhen: false,
//         sound:
//             RawResourceAndroidNotificationSound('sound.wav'.split('.').first),
//       );
//
//       /// Define iOS notification details
//       final DarwinNotificationDetails iosNotificationDetails =
//           const DarwinNotificationDetails(
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: true,
//       );
//       NotificationDetails details = NotificationDetails(
//         android: androidNotificationDetails,
//         iOS: iosNotificationDetails,
//       );
//       await flutterLocalNotificationsPlugin.show(
//           basicNotificationId,
//           "Notification $basicNotificationId",
//           "This is the Notification Description for Notification Id: $basicNotificationId",
//           details,
//           payload: "Payload Data");
//     } catch (e, stackTrace) {
//       debugPrint("Error Showing Basic Notification: $e");
//       debugPrint("Stack trace: $stackTrace");
//     }
//   }
//
//   Future<void> showRepeatedNotification() async {
//     try {
//       /// Define Android notification details
//       final AndroidNotificationDetails androidNotificationDetails =
//           const AndroidNotificationDetails(
//         channelId,
//         channelName,
//         channelDescription: channelDescription,
//         importance: Importance.max,
//         priority: Priority.high,
//         playSound: true,
//         enableVibration: true,
//         showWhen: false,
//       );
//
//       /// Define IOS notification details
//       final DarwinNotificationDetails iosNotificationDetails =
//           const DarwinNotificationDetails(
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: true,
//       );
//
//       /// Define Android & IOS notification Details
//       final NotificationDetails details = NotificationDetails(
//         android: androidNotificationDetails,
//         iOS: iosNotificationDetails,
//       );
//
//       /// Showing Notification Repeatedly
//       await flutterLocalNotificationsPlugin.periodicallyShow(
//         repeatedNotificationId,
//         "Repeated Notification $repeatedNotificationId",
//         "Showing Notification Repeatedly",
//         RepeatInterval.everyMinute,
//         details,
//         payload: "Payload Data",
//         androidScheduleMode: AndroidScheduleMode.exact,
//       );
//     } catch (e, stackTrace) {
//       debugPrint("Error Showing Repeated Notification: $e");
//       debugPrint("Stack trace: $stackTrace");
//     }
//   }
//
//   Future<void> showScheduledNotification() async {
//     try {
//       tz.initializeTimeZones();
//       final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
//       tz.setLocalLocation(tz.getLocation(currentTimeZone));
//
//       /// Define Android notification details
//       final AndroidNotificationDetails androidNotificationDetails =
//           const AndroidNotificationDetails(
//         channelId,
//         channelName,
//         channelDescription: channelDescription,
//         importance: Importance.max,
//         priority: Priority.high,
//         playSound: true,
//         enableVibration: true,
//       );
//
//       /// Define IOS notification details
//       final DarwinNotificationDetails iosNotificationDetails =
//           const DarwinNotificationDetails(
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: true,
//       );
//
//       /// Define Android & IOS notification Details
//       final NotificationDetails details = NotificationDetails(
//         android: androidNotificationDetails,
//         iOS: iosNotificationDetails,
//       );
//
//       /// Showing Notification Repeatedly
//       await flutterLocalNotificationsPlugin.zonedSchedule(
//         scheduledNotificationId,
//         "Notification $scheduledNotificationId",
//         "This is the Notification Description for Notification Id: $scheduledNotificationId",
//         tz.TZDateTime.now(tz.local).add(Duration(seconds: 10)),
//         details,
//         payload: "Payload Data",
//         androidScheduleMode: AndroidScheduleMode.alarmClock,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//       );
//     } catch (e, stackTrace) {
//       debugPrint("Error Showing Scheduled Notification: $e");
//       debugPrint("Stack trace: $stackTrace");
//     }
//   }
//
//   Future<void> cancelNotification(int id) async =>
//       await flutterLocalNotificationsPlugin.cancel(id);
// }

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
//
// class NotificationService {
//   static final NotificationService _instance = NotificationService._internal();
//
//   factory NotificationService() => _instance;
//
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   NotificationService._internal();
//
//   Future<void> init() async {
//     tz.initializeTimeZones();
//
//     const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const initSettings = InitializationSettings(android: androidInit);
//
//     await _flutterLocalNotificationsPlugin.initialize(initSettings);
//   }
//
//   Future<void> scheduleDailyNotification({
//     required int id,
//     required String title,
//     required String body,
//     required DateTime time,
//   }) async {
//     final androidDetails = AndroidNotificationDetails(
//       'med_reminder_channel',
//       'Medication Reminders',
//       channelDescription: 'تذكير بموعد تناول الدواء',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     final notificationDetails = NotificationDetails(android: androidDetails);
//
//     final now = DateTime.now();
//     final scheduledDate = _nextInstanceOfTime(time);
//
//     await _flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       scheduledDate,
//       notificationDetails,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//     );
//   }
//
//   tz.TZDateTime _nextInstanceOfTime(DateTime time) {
//     final now = tz.TZDateTime.now(tz.local);
//     var scheduledDate = tz.TZDateTime(
//       tz.local,
//       now.year,
//       now.month,
//       now.day,
//       time.hour,
//       time.minute,
//     );
//
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//
//     return scheduledDate;
//   }
//
//   Future<void> cancelNotification(int id) async {
//     await _flutterLocalNotificationsPlugin.cancel(id);
//   }
//
//   Future<void> cancelAllNotifications() async {
//     await _flutterLocalNotificationsPlugin.cancelAll();
//   }
// }

import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future init() async {
    // طلب صلاحية POST_NOTIFICATIONS على Android 13+
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        final status = await Permission.notification.status;
        if (!status.isGranted) {
          await Permission.notification.request();
        }
      }
    }

    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );

    _flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );

    log(
      "LocalNotificationService Has Been Initialized",
      name: "Local Notification Service",
    );
  }

  static onDidReceiveNotificationResponse(NotificationResponse details) {}
  static onDidReceiveBackgroundNotificationResponse(
      NotificationResponse details) {}

  static Future showBasicNotification({
    int? id,
    String? title,
    String? body,
    NotificationDetails? customNotificationDetails,
    String? payload,
  }) async {
    String sound = "sound.wav".split(".").first;
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "id 1",
      "App Name ",
      importance: Importance.max,
      priority: Priority.high,
      // sound: RawResourceAndroidNotificationSound(sound),
    );

    DarwinNotificationDetails iOSNotificationDetails =
        const DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOSNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      id ?? 0,
      title ?? "Basic Notification",
      body ?? "show Basic Notification in simple way",
      customNotificationDetails ?? notificationDetails,
      payload: payload ?? "Notification Payload",
    );
  }

  static Future showRepeatedNotification({
    int? id,
    String? title,
    String? body,
    NotificationDetails? customNotificationDetails,
    String? payload,
  }) async {
    String sound = "sound.wav".split(".").first;

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "id 2",
      "App Name",
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound(sound),
    );

    DarwinNotificationDetails iOSNotificationDetails =
        const DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOSNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.periodicallyShow(
      id ?? 0,
      title ?? "Repeated Notification",
      body ?? "show Repeated Notification in simple way",
      RepeatInterval.everyMinute,
      customNotificationDetails ?? notificationDetails,
      payload: payload ?? "Notification Payload",
      androidScheduleMode: AndroidScheduleMode.exact,
    );
  }

  static Future showScheduledNotification({
    int? id,
    String? title,
    String? body,
    NotificationDetails? customNotificationDetails,
    String? payload,
  }) async {
    String sound = "sound.wav".split(".").first;

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "id 3",
      "App Name",
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound(sound),
    );

    DarwinNotificationDetails iOSNotificationDetails =
        const DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOSNotificationDetails,
    );

    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id ?? 0,
      title ?? "Scheduled Notification",
      body ?? "Show Scheduled Notification in simple way",
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      customNotificationDetails ?? notificationDetails,
      payload: payload ?? "Notification Payload",
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      // matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  static Future showDailyScheduledNotification({
    int? id,
    String? title,
    String? body,
    required DateTime time,
    NotificationDetails? customNotificationDetails,
    String? payload,
  }) async {
    String sound = "sound.wav".split(".").first;

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "id 4",
      "App Name",
      importance: Importance.max,
      priority: Priority.high,
      // sound: RawResourceAndroidNotificationSound(sound),
    );

    DarwinNotificationDetails iOSNotificationDetails =
        const DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOSNotificationDetails,
    );

    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    final scheduledDate = _nextInstanceOfTime(time);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id ?? 0,
      title ?? "Basic Notification",
      body ?? "Show Scheduled Notification in simple way",
      scheduledDate,
      customNotificationDetails ?? notificationDetails,
      payload: payload ?? "Notification Payload",
      androidScheduleMode: AndroidScheduleMode.exact,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  static tz.TZDateTime _nextInstanceOfTime(DateTime time) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  static void cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
}
