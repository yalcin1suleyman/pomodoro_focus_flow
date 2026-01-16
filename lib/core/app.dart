import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/home/home_screen.dart';
import '../../features/settings/settings_provider.dart';

class FocusFlowApp extends StatelessWidget {
  const FocusFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      title: 'Focus Flow',
      debugShowCheckedModeBanner: false,
      theme: settings.themeData,
      home: const HomeScreen(),
    );
  }
}
