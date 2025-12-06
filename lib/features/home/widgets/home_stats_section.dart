import 'package:flutter/material.dart';
import 'package:pomodoro_focus_flow1/models/timer_models.dart';

class HomeStatsSection extends StatelessWidget {
  final double efficiency; // 0–100
  final Duration wastedTime; // toplam duraklama süresi
  final List<PauseEntry> pauses; // oturum boyunca duraklamalar
  final double sessionProgress; // 0.0–1.0 (nominal odak süresi ilerleyişi)
  final bool isRunning; // bar yazısı için

  final bool showStats; // Focus modunda true
  final bool showBreakMessage; // Break modunda true

  final String mottoText;
  final VoidCallback onEditMotto;
  final VoidCallback onShuffleMotto;

  final Color accentColor; // tema ana rengi
  final Color warningColor; // pause rengi
  final int totalSeconds; // seçili modun toplam süresi (saniye)

  const HomeStatsSection({
    super.key,
    required this.efficiency,
    required this.wastedTime,
    required this.pauses,
    required this.sessionProgress,
    required this.isRunning,
    required this.mottoText,
    required this.onEditMotto,
    required this.onShuffleMotto,
    required this.accentColor,
    required this.warningColor,
    required this.totalSeconds,
    this.showStats = true,
    this.showBreakMessage = false,
  });

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      _buildMottoCard(),
    ];

    if (showStats) {
      items.add(const SizedBox(height: 16));
      items.add(_buildEfficiencyRow());

      items.add(const SizedBox(height: 16));
      items.add(_buildTimelineCard());

      items.add(const SizedBox(height: 16));
      items.add(_buildBottomTimelineBar());
    }

    if (showBreakMessage) {
      items.add(const SizedBox(height: 12));
      items.add(
        const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            "Enjoy your break ☕",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }

  // ───────────────────────── 1) Motto Card ─────────────────────────
  Widget _buildMottoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.format_quote_rounded,
            color: Colors.white70,
            size: 24,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "MOTTO OF THE DAY",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  mottoText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: onEditMotto,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(
              Icons.edit_outlined,
              color: Colors.white54,
              size: 18,
            ),
          ),
          const SizedBox(width: 4),
          IconButton(
            onPressed: onShuffleMotto,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(
              Icons.refresh_rounded,
              color: Colors.white54,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  // ────────────────── 2) Efficiency + Wasted Time Row ──────────────────
  Widget _buildEfficiencyRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: _cardDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.speed, color: Colors.white70, size: 18),
                    SizedBox(width: 6),
                    Text(
                      "Real Efficiency",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "${efficiency.toStringAsFixed(0)}%",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Based on wall clock time",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: _cardDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.hourglass_bottom,
                        color: Colors.white70, size: 18),
                    SizedBox(width: 6),
                    Text(
                      "Wasted Time",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "${wastedTime.inMinutes}m ${wastedTime.inSeconds % 60}s",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Total paused duration",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ───────────────────── 3) Session Timeline Card ─────────────────────
  Widget _buildTimelineCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.refresh_rounded, size: 18, color: Colors.white70),
              SizedBox(width: 6),
              Text(
                "Session Timeline",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 160,
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white24,
              ),
            ),
            child: pauses.isEmpty
                ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle_outline,
                      size: 30, color: Colors.white38),
                  SizedBox(height: 8),
                  Text(
                    "No interruptions yet.",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              itemCount: pauses.length,
              itemBuilder: (context, index) {
                final p = pauses[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        p.timeLabel,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        "${p.durationSeconds}s",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────── 4) Alt Timeline Bar ─────────────────────
  Widget _buildBottomTimelineBar() {
    final int total = totalSeconds <= 0 ? 1 : totalSeconds;

    // Nominal focus süresi (timer'ın ilerleyişi)
    final int elapsedFocus =
    (sessionProgress.clamp(0.0, 1.0) * total).round();

    // Pause'ları kronolojik sıraya koy
    final sortedPauses = [...pauses]
      ..sort((a, b) => a.atSecond.compareTo(b.atSecond));

    final segments = <_TimelineSegment>[];
    int cursor = 0;

    for (final p in sortedPauses) {
      // Pause'un başladığı nokta (focus ekseninde)
      final start = p.atSecond.clamp(0, total);
      final end = (p.atSecond + p.durationSeconds).clamp(0, total);

      // Öncesi focus segmenti
      if (start > cursor) {
        final focusEnd = start.clamp(0, elapsedFocus);
        if (focusEnd > cursor) {
          segments.add(_TimelineSegment(
            length: focusEnd - cursor,
            color: accentColor,
          ));
        }
        cursor = start;
      }

      // Pause segmenti
      final pauseStart = cursor;
      final pauseEnd = end.clamp(pauseStart, total);
      if (pauseEnd > pauseStart) {
        segments.add(_TimelineSegment(
          length: pauseEnd - pauseStart,
          color: warningColor,
        ));
        cursor = pauseEnd;
      }

      if (cursor >= total) break;
    }

    // Son pause'dan sonra kalan focus (elapsedFocus'a kadar)
    if (elapsedFocus > cursor) {
      final focusEnd = elapsedFocus.clamp(cursor, total);
      if (focusEnd > cursor) {
        segments.add(_TimelineSegment(
          length: focusEnd - cursor,
          color: accentColor,
        ));
        cursor = focusEnd;
      }
    }

    // Kalan (henüz başlanmamış) kısım
    if (cursor < total) {
      segments.add(_TimelineSegment(
        length: total - cursor,
        color: Colors.white12,
      ));
    }

    final hasAny = segments.isNotEmpty;

    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: Colors.white10,
        border: Border.all(color: Colors.white24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        children: [
          // Sol: başlık + bar
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Session balance",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: hasAny
                      ? Row(
                    children: [
                      for (final seg in segments)
                        Expanded(
                          flex: seg.length,
                          child: Container(
                            height: 12,
                            color: seg.color,
                          ),
                        ),
                    ],
                  )
                      : Container(
                    height: 6,
                    color: Colors.white12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Sağ: durum yazısı
          Text(
            isRunning ? "Session in progress" : "Ready to start",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // Ortak kart dekorasyonu
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white10,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.white12),
    );
  }
}

class _TimelineSegment {
  final int length;
  final Color color;

  _TimelineSegment({
    required this.length,
    required this.color,
  });
}
