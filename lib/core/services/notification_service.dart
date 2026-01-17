import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> init() async {
    try {
      tz.initializeTimeZones();
      // Set a default location to avoid LateInitializationError
      tz.setLocalLocation(tz.getLocation('UTC'));

      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      final DarwinInitializationSettings initializationSettingsDarwin =
          DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
      );

      final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
      );

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (details) {
          // Handle notification tap
        },
      );

      // Explicitly request permissions for Android 13+
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      if (androidImplementation != null) {
        await androidImplementation.requestNotificationsPermission();
      }

    } catch (e) {
      debugPrint("Notification Init Error: $e");
    }
  }

  // Show persistent progress notification
  Future<void> showOngoingNotification({
    required int progress,
    required int maxProgress,
    required String title,
    required String body,
  }) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'pomodoro_ongoing_channel', 
      'Ongoing Timer',
      channelDescription: 'Shows the running timer progress',
      importance: Importance.low, // Low importance = no sound/vibration, just visual update
      priority: Priority.low,
      ongoing: true,
      autoCancel: false,
      showProgress: true,
      maxProgress: maxProgress,
      progress: progress,
      onlyAlertOnce: true,
    );

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // ID 0 for Ongoing
      title,
      body,
      platformChannelSpecifics,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
  
  Future<void> cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  // Show alarm immediately (Top priority)
  Future<void> showAlarmNow({required bool useAppBell}) async {
    debugPrint("showAlarmNow called. useAppBell: $useAppBell");
    
    // 1. Play Sound (Custom Guitar)
    if (useAppBell) {
      try {
        await _audioPlayer.stop();
        await _audioPlayer.setVolume(1.0);
        await _audioPlayer.setReleaseMode(ReleaseMode.stop);
        await _audioPlayer.play(AssetSource('sounds/ses1.wav'));
      } catch (e) {
        debugPrint("Audio Play Error: $e");
      }
    }

    // 2. Show Visual Notification (High Priority)
    // We use a FRESH Channel ID to ensure sound settings are re-applied by OS
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'pomodoro_alarm_channel_final', // NEW ID to reset settings
      'Timer Completion Alarms',
      channelDescription: 'Notifications for timer completion with sound',
      importance: Importance.max,
      priority: Priority.high,
      playSound: !useAppBell, // True = System Sound, False = Silent (since we play Guitar)
      fullScreenIntent: true,
      visibility: NotificationVisibility.public,
    );

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      1, // ID 1 for Alarm
      'Time is up!', 
      'Pomodoro session completed.', 
      platformChannelSpecifics,
    );
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }
}
