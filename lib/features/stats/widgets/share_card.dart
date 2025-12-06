import 'package:flutter/material.dart';

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
            "$rangeLabel Summary",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            "$hours h",
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "focused",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "$totalSessions sessions",
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            "Share your streak and keep yourself accountable 🚀",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}
