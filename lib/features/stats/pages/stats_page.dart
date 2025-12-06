import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../models/timer_models.dart';
import '../widgets/share_card.dart';

enum StatsRange { today, week, month, sixMonths, year }

class StatsPage extends StatefulWidget {
  final List<FocusSession> history;

  const StatsPage({
    super.key,
    required this.history,
  });

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  StatsRange _range = StatsRange.week;
  final GlobalKey _shareKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredSessions();
    final totalMinutes = _totalFocusMinutes(filtered);
    final totalSessions = filtered.length;
    final buckets = _buildDailyBuckets(filtered);
    final label = _rangeLabel;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Statistics"),
      ),
      body: widget.history.isEmpty
          ? const Center(
        child: Text(
          "No sessions yet.\nFinish a pomodoro to see stats.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _rangeChips(),
            const SizedBox(height: 16),
            _summaryRow(totalMinutes, totalSessions),
            const SizedBox(height: 16),
            Expanded(
              child: _bucketList(buckets),
            ),
            const SizedBox(height: 12),

            // Paylaşılacak kartın önizlemesi
            RepaintBoundary(
              key: _shareKey,
              child: ShareSummaryCard(
                rangeLabel: label,
                totalMinutes: totalMinutes,
                totalSessions: totalSessions,
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _shareAsImage(context),
                icon: const Icon(Icons.share),
                label: const Text("Share as image"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ───────────────────── Range seçimi ─────────────────────

  Widget _rangeChips() {
    Widget chip(String label, StatsRange value) {
      final selected = _range == value;
      return ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) {
          setState(() {
            _range = value;
          });
        },
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          chip("Today", StatsRange.today),
          const SizedBox(width: 8),
          chip("Week", StatsRange.week),
          const SizedBox(width: 8),
          chip("Month", StatsRange.month),
          const SizedBox(width: 8),
          chip("6M", StatsRange.sixMonths),
          const SizedBox(width: 8),
          chip("1Y", StatsRange.year),
        ],
      ),
    );
  }

  String get _rangeLabel {
    switch (_range) {
      case StatsRange.today:
        return "Today";
      case StatsRange.week:
        return "This week";
      case StatsRange.month:
        return "This month";
      case StatsRange.sixMonths:
        return "Last 6 months";
      case StatsRange.year:
        return "This year";
    }
  }

  // ───────────────────── Özet kartları ─────────────────────

  Widget _summaryRow(int totalMinutes, int totalSessions) {
    final hours = (totalMinutes / 60).toStringAsFixed(1);

    return Row(
      children: [
        _miniCard(
          label: "Focused",
          value: "$hours h",
          icon: Icons.timer_rounded,
        ),
        const SizedBox(width: 8),
        _miniCard(
          label: "Sessions",
          value: "$totalSessions",
          icon: Icons.check_circle_outline,
        ),
      ],
    );
  }

  Widget _miniCard({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18, color: Colors.white70),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white60,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ───────────────────── Günlük bucket listesi ─────────────────────

  Widget _bucketList(List<_Bucket> buckets) {
    if (buckets.isEmpty) {
      return const Center(
        child: Text(
          "No data in this range yet.",
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    final maxMinutes = buckets
        .map((b) => b.focusMinutes)
        .fold<int>(0, (a, b) => b > a ? b : a)
        .clamp(1, 100000);

    return ListView.separated(
      itemCount: buckets.length,
      separatorBuilder: (_, __) => const SizedBox(height: 6),
      itemBuilder: (context, index) {
        final b = buckets[index];
        final ratio = b.focusMinutes / maxMinutes;

        return Row(
          children: [
            SizedBox(
              width: 68,
              child: Text(
                b.label,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white70,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: ratio.clamp(0.05, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 60,
              child: Text(
                "${b.focusMinutes} min",
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ───────────────────── SHARE AS IMAGE ─────────────────────

  Future<void> _shareAsImage(BuildContext context) async {
    try {
      final boundary =
      _shareKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not capture card")),
        );
        return;
      }

      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      final dir = await getTemporaryDirectory();
      final file =
      await File('${dir.path}/focusflow_summary.png').create();
      await file.writeAsBytes(pngBytes);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: "My FocusFlow summary 📈",
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Share failed: $e")),
      );
    }
  }

  // ───────────────────── Hesaplama yardımcıları ─────────────────────

  List<FocusSession> _filteredSessions() {
    final now = DateTime.now();
    DateTime from;

    switch (_range) {
      case StatsRange.today:
        from = DateTime(now.year, now.month, now.day);
        break;
      case StatsRange.week:
        from = now.subtract(const Duration(days: 6));
        break;
      case StatsRange.month:
        from = now.subtract(const Duration(days: 30));
        break;
      case StatsRange.sixMonths:
        from = now.subtract(const Duration(days: 180));
        break;
      case StatsRange.year:
        from = now.subtract(const Duration(days: 365));
        break;
    }

    return widget.history
        .where((s) => !s.startTime.isBefore(from))
        .toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  int _totalFocusMinutes(List<FocusSession> sessions) {
    final totalSeconds =
    sessions.fold<int>(0, (sum, s) => sum + s.focusSeconds);
    return (totalSeconds / 60).round();
  }

  List<_Bucket> _buildDailyBuckets(List<FocusSession> sessions) {
    final Map<DateTime, int> map = {};

    for (final s in sessions) {
      final d =
      DateTime(s.startTime.year, s.startTime.month, s.startTime.day);
      map[d] = (map[d] ?? 0) + (s.focusSeconds / 60).round();
    }

    final keys = map.keys.toList()..sort();
    return [
      for (final k in keys)
        _Bucket(
          date: k,
          focusMinutes: map[k] ?? 0,
        ),
    ];
  }
}

class _Bucket {
  final DateTime date;
  final int focusMinutes;

  _Bucket({
    required this.date,
    required this.focusMinutes,
  });

  String get label =>
      "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}";
}
