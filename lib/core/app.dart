import 'package:flutter/material.dart';

import '../features/home/pages/home_page.dart';

class FocusFlowApp extends StatelessWidget {
  const FocusFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FocusFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
      ),
      home: const FocusFlowHomePage(),
    );
  }
}
