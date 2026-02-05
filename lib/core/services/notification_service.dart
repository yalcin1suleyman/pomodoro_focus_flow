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
  Future<void> showAlarmNow({
    required bool useAppBell, 
    required String title, 
    required String body,
  }) async {
    debugPrint("showAlarmNow called. useAppBell: $useAppBell");
    
    // 1. Play Sound (Custom Guitar)
    if (useAppBell) {
      try {
        await _audioPlayer.stop();
        await _audioPlayer.setVolume(1.0);
        await _audioPlayer.setReleaseMode(ReleaseMode.stop);
        await _audioPlayer.play(AssetSource('sounds/bell.mp3'));
      } catch (e) {
        debugPrint("Audio Play Error: $e");
      }
    }

    // 2. Show Visual Notification (High Priority)
    // CRITICAL: Android Channels are immutable. We MUST use different IDs for Silent vs Sound.
    final String channelId = useAppBell ? 'pomodoro_alarm_silent_v2' : 'pomodoro_alarm_system_v2';
    final String channelName = useAppBell ? 'Timer Alarms (Silent)' : 'Timer Alarms (System Sound)';
    
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: 'Notifications for timer completion',
      importance: Importance.max,
      priority: Priority.high,
      playSound: !useAppBell, // True if NOT using App Bell
      sound: !useAppBell ? const RawResourceAndroidNotificationSound('notification') : null, // Default system sound or custom if needed
      fullScreenIntent: true,
      visibility: NotificationVisibility.public,
    );

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      1, // ID 1 for Alarm
      title, 
      body, 
      platformChannelSpecifics,
    );
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }
}
