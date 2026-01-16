import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app.dart';
import 'features/settings/settings_provider.dart';
import 'features/tasks/task_provider.dart';
import 'features/timer/timer_service.dart';
import 'features/stats/history_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => TimerService()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ],
      child: const FocusFlowApp(),
    ),
  );
}
