import 'package:flutter/material.dart';
import 'package:pomodoro_focus_flow1/models/timer_models.dart';

class HistoryPage extends StatelessWidget {
  final List<FocusSession> history;

  const HistoryPage({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Session History"),
      ),
      body: history.isEmpty
          ? const Center(
        child: Text(
          "No sessions yet.",
          style: TextStyle(color: Colors.white70),
        ),
      )
          : ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final s = history[history.length - 1 - index];
          return ListTile(
            title: Text(
              "${s.mode.name} • ${s.focusSeconds ~/ 60}m focus",
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "Wasted: ${s.wastedSeconds ~/ 60}m\n${s.startTime}",
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          );
        },
      ),
    );
  }
}
