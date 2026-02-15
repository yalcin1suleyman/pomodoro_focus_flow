import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../settings/settings_provider.dart';

class ShareSummaryCard extends StatelessWidget {
  final String rangeLabel;
  final int totalMinutes;
  final int totalSessions;

  const ShareSummaryCard({
    super.key,
    required this.rangeLabel,
    required this.totalMinutes,
    required this.totalSessions,
  });

  @override
  Widget build(BuildContext context) {
    final hours = (totalMinutes / 60).toStringAsFixed(1);

    return Container(
      width: 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1F2937)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "FocusFlow",
            style: TextStyle(
              fontSize: 14,
              letterSpacing: 1,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "$rangeLabel ${Provider.of<SettingsProvider>(context).translate('shareSummary')}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            "$hours ${Provider.of<SettingsProvider>(context).translate('hours').substring(0, 1).toLowerCase()}",
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            Provider.of<SettingsProvider>(context).translate('shareFocused'),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "$totalSessions ${Provider.of<SettingsProvider>(context).translate('shareSessions')}",
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            Provider.of<SettingsProvider>(context).translate('shareStreak'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}
