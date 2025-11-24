import 'package:flutter/material.dart';
import '../../../models/timer_models.dart';

class HomeStatsSection extends StatelessWidget {
  final double efficiency;          // 0–100
  final Duration wastedTime;        // toplam duraklama süresi
  final List<PauseEntry> pauses;    // oturum boyunca duraklamalar
  final double sessionProgress;     // 0.0–1.0 arası
  final bool isRunning;             // bar yazısı için

  const HomeStatsSection({
    super.key,
    required this.efficiency,
    required this.wastedTime,
    required this.pauses,
    required this.sessionProgress,
    required this.isRunning,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMottoCard(),
        const SizedBox(height: 16),
        _buildEfficiencyRow(),
        const SizedBox(height: 16),
        _buildTimelineCard(),
        const SizedBox(height: 16),
        _buildBottomProgressBar(),
      ],
    );
  }

  // ───────────────────────── 1) Motto Card ─────────────────────────
  Widget _buildMottoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.format_quote_rounded,
              color: Colors.white70, size: 24),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "MOTTO OF THE DAY",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "\"Well begun is half done.\"",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Icon(Icons.edit_outlined, color: Colors.white54, size: 18),
          SizedBox(width: 8),
          Icon(Icons.refresh_rounded, color: Colors.white54, size: 18),
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
                  "Based on Wall Clock Time",
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
                  "Total Paused Duration",
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
              Icon(Icons.refresh_rounded,
                  size: 18, color: Colors.white70),
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
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
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

  // ───────────────────── 4) Bottom Progress Bar ─────────────────────
  Widget _buildBottomProgressBar() {
    final factor = sessionProgress.clamp(0.0, 1.0);

    return Container(
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: Colors.white12,
      ),
      child: Stack(
        children: [
          FractionallySizedBox(
            widthFactor: factor == 0 ? 0.02 : factor,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: Colors.blueAccent.withOpacity(0.8),
              ),
            ),
          ),
          Center(
            child: Text(
              isRunning ? "Session in progress" : "Ready to start",
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white10,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.white12),
    );
  }
}
