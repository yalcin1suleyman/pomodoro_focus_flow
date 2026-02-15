import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'core/app.dart';
import 'features/settings/settings_provider.dart';
import 'features/tasks/task_provider.dart';
import 'features/timer/timer_service.dart';
import 'features/stats/history_provider.dart';
import 'core/services/notification_service.dart';
import 'core/services/ad_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await NotificationService().init();
    await AdService().init();
  } catch (e) {
    debugPrint("Failed to initialize services: $e");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProxyProvider<SettingsProvider, TimerService>(
          create: (_) => TimerService(),
          update: (_, settings, timer) {
            timer?.updateSettings(
              settings.pomodoroMinutes, 
              settings.shortBreakMinutes, 
              settings.longBreakMinutes,
              settings.soundType,
              settings.currentLanguageObj,
            );
            return timer!;
          },
        ),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ],
      child: const FocusFlowApp(),
    ),
  );
}
