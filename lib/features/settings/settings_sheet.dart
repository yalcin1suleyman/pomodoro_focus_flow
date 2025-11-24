import 'package:flutter/material.dart';
import '../../models/theme_models.dart';
import '../../models/timer_models.dart';

enum AppLanguage { tr, en }

class SettingsSheet extends StatefulWidget {
  final FocusTheme theme;
  final TimerConfig config;
  final AppLanguage language;

  final void Function(
      FocusThemeType themeType,
      TimerConfig newConfig,
      AppLanguage language,
      ) onApply;

  const SettingsSheet({
    super.key,
    required this.theme,
    required this.config,
    required this.language,
    required this.onApply,
  });

  @override
  State<SettingsSheet> createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<SettingsSheet> {
  late FocusThemeType _selectedTheme;
  late AppLanguage _selectedLang;
  late double _focusMinutes;
  late double _shortMinutes;
  late double _longMinutes;

  @override
  void initState() {
    super.initState();
    _selectedTheme = widget.theme.type;
    _selectedLang = widget.language;
    _focusMinutes = widget.config.focusMinutes.toDouble();
    _shortMinutes = widget.config.shortBreakMinutes.toDouble();
    _longMinutes = widget.config.longBreakMinutes.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.theme;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
        color: const Color(0xFF020617),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            children: [
              Text(
                _selectedLang == AppLanguage.tr ? "Ayarlar" : "Settings",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Dil
          _sectionLabel("Dil / Language"),
          const SizedBox(height: 6),
          _buildLanguageToggle(),

          const SizedBox(height: 16),

          // Tema & Atmosfer
          _sectionLabel(
            _selectedLang == AppLanguage.tr
                ? "Tema & Atmosfer"
                : "Theme & Atmosphere",
          ),
          const SizedBox(height: 8),
          _buildThemeRow(),

          const SizedBox(height: 16),

          // Zamanlayıcı Süreleri
          _sectionLabel(
            _selectedLang == AppLanguage.tr
                ? "Zamanlayıcı Süreleri (Dakika)"
                : "Timer Durations (Minutes)",
          ),
          const SizedBox(height: 8),

          // Odak Süresi (Zen / Klasik etiketiyle)
          _buildSlider(
            label: _selectedLang == AppLanguage.tr
                ? "Odak Süresi"
                : "Focus Duration",
            badgeText: _focusMinutes >= 120 ? "Zen Modu" : "Klasik",
            value: _focusMinutes,
            min: 10,
            max: 180,
            color: t.accent,
            onChanged: (v) => setState(() => _focusMinutes = v),
          ),
          const SizedBox(height: 8),

          _buildSlider(
            label: _selectedLang == AppLanguage.tr ? "Kısa Mola" : "Short Break",
            value: _shortMinutes,
            min: 3,
            max: 30,
            color: Colors.greenAccent,
            onChanged: (v) => setState(() => _shortMinutes = v),
          ),
          const SizedBox(height: 8),

          _buildSlider(
            label: _selectedLang == AppLanguage.tr ? "Uzun Mola" : "Long Break",
            value: _longMinutes,
            min: 5,
            max: 60,
            color: Colors.lightBlueAccent,
            onChanged: (v) => setState(() => _longMinutes = v),
          ),

          const SizedBox(height: 16),

          // Öneri kutusu (odak süresine göre dinamik)
          _buildSuggestionCard(),

          const SizedBox(height: 16),

          // Tamam butonu
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: t.accent,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              onPressed: () {
                widget.onApply(
                  _selectedTheme,
                  TimerConfig(
                    focusMinutes: _focusMinutes.round(),
                    shortBreakMinutes: _shortMinutes.round(),
                    longBreakMinutes: _longMinutes.round(),
                  ),
                  _selectedLang,
                );
                Navigator.pop(context);
              },
              child: Text(
                _selectedLang == AppLanguage.tr ? "Tamam" : "Done",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.white70,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildLanguageToggle() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: [
          _langChip("Türkçe", AppLanguage.tr),
          _langChip("English", AppLanguage.en),
        ],
      ),
    );
  }

  Widget _langChip(String label, AppLanguage lang) {
    final selected = _selectedLang == lang;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedLang = lang),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.black : Colors.white70,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeRow() {
    return Row(
      children: FocusThemes.all.map((t) {
        final selected = t.type == _selectedTheme;
        IconData icon;
        switch (t.type) {
          case FocusThemeType.cosmic:
            icon = Icons.rocket_launch;
            break;
          case FocusThemeType.sakura:
            icon = Icons.local_florist;
            break;
          case FocusThemeType.ocean:
            icon = Icons.sailing;
            break;
          case FocusThemeType.forest:
            icon = Icons.park;
            break;
        }

        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedTheme = t.type),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: selected ? Colors.white10 : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: selected ? Colors.white : Colors.white24,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 18, color: Colors.white),
                  const SizedBox(height: 4),
                  Text(
                    t.name,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSlider({
    required String label,
    String? badgeText,
    required double value,
    required double min,
    required double max,
    required Color color,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white70,
              ),
            ),
            const Spacer(),
            if (badgeText != null)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Text(
                  badgeText,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.pinkAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                "${value.round()}",
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            thumbShape:
            const RoundSliderThumbShape(enabledThumbRadius: 8),
            overlayShape:
            const RoundSliderOverlayShape(overlayRadius: 16),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            activeColor: color,
            inactiveColor: Colors.white24,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestionCard() {
    final int focus = _focusMinutes.round();
    String text;

    if (focus >= 120) {
      text =
      "Öneri: Çok uzun odak süreleri zihinsel yorgunluğu artırabilir. "
          "Ara ara kısa molalar vermek verimini korumana yardımcı olur.";
    } else if (focus <= 20) {
      text =
      "Öneri: Çok kısa odak süreleri derinleşmeyi zorlaştırabilir. "
          "25–45 dakika arası odak bloklarını deneyebilirsin.";
    } else {
      text =
      "Öneri: Uzun odak süreleri zihinsel yorgunluğu artırabilir. "
          "Verimini korumak için kısa molayı 10 dakika civarında tutmaya "
          "çalışabilirsin.";
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, size: 18, color: Colors.white70),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
