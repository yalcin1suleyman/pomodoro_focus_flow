import 'package:flutter/material.dart';

import '../../../models/theme_models.dart';
import '../../../models/timer_models.dart';
import '../../../core/localization/app_language.dart';



class SettingsSheet extends StatefulWidget {
  final FocusTheme theme;
  final TimerConfig config;
  final AppLanguage language;

  final bool autoStartBreaks;
  final bool autoStartNextFocus;
  final bool tickingSound;
  final bool alarmSound;

  final void Function(
      FocusThemeType themeType,
      TimerConfig newConfig,
      AppLanguage language,
      bool autoStartBreaks,
      bool autoStartNextFocus,
      bool tickingSound,
      bool alarmSound,
      ) onApply;

  const SettingsSheet({
    super.key,
    required this.theme,
    required this.config,
    required this.language,
    required this.autoStartBreaks,
    required this.autoStartNextFocus,
    required this.tickingSound,
    required this.alarmSound,
    required this.onApply,
  });

  @override
  State<SettingsSheet> createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<SettingsSheet> {
  late FocusThemeType _selectedTheme;
  late AppLanguage _selectedLang;

  late double _focus;
  late double _shortB;
  late double _longB;

  late bool _autoStartBreaks;
  late bool _autoStartNextFocus;
  late bool _tickingSound;
  late bool _alarmSound;

  @override
  void initState() {
    super.initState();
    _selectedTheme = widget.theme.type;
    _selectedLang = widget.language;

    _focus = widget.config.focusMinutes.toDouble();
    _shortB = widget.config.shortBreakMinutes.toDouble();
    _longB = widget.config.longBreakMinutes.toDouble();

    _autoStartBreaks = widget.autoStartBreaks;
    _autoStartNextFocus = widget.autoStartNextFocus;
    _tickingSound = widget.tickingSound;
    _alarmSound = widget.alarmSound;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF020617),
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
            const SizedBox(height: 16),

            _sectionLabel(tt(_selectedLang, "Süre Ayarları", "Timer")),
            const SizedBox(height: 8),
            _sliderRow(
              tt(_selectedLang, "Odak", "Focus"),
              _focus,
              10,
              180,
              onChanged: (v) => setState(() => _focus = v),
            ),
            const SizedBox(height: 8),
            _sliderRow(
              tt(_selectedLang, "Kısa Mola", "Short Break"),
              _shortB,
              3,
              30,
              onChanged: (v) => setState(() => _shortB = v),
            ),
            const SizedBox(height: 8),
            _sliderRow(
              tt(_selectedLang, "Uzun Mola", "Long Break"),
              _longB,
              0,
              60,
              onChanged: (v) => setState(() => _longB = v),
            ),
            const SizedBox(height: 8),
            _autoStartToggles(),

            const SizedBox(height: 16),

            _sectionLabel(tt(_selectedLang, "Ses Ayarları", "Sound")),
            const SizedBox(height: 4),
            _soundToggles(),

            const SizedBox(height: 16),

            _sectionLabel(tt(_selectedLang, "Tema", "Theme")),
            const SizedBox(height: 8),
            _themeRow(),

            const SizedBox(height: 16),

            _sectionLabel(tt(_selectedLang, "Dil", "Language")),
            const SizedBox(height: 8),
            _languageRow(),

            const SizedBox(height: 24),
            _saveButton(),
          ],
        ),
      ),
    );
  }

  // ───────────────────── HEADER ─────────────────────

  Widget _header() {
    return Row(
      children: [
        Text(
          tt(_selectedLang, "Ayarlar", "Settings"),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }

  Widget _sectionLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // ───────────────────── SLIDERS ─────────────────────

  Widget _sliderRow(
      String title,
      double value,
      double min,
      double max, {
        required ValueChanged<double> onChanged,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title),
            const Spacer(),
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text("${value.round()} min"),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          activeColor: widget.theme.accent,
          inactiveColor: Colors.white24,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _autoStartToggles() {
    return Column(
      children: [
        SwitchListTile.adaptive(
          value: _autoStartBreaks,
          onChanged: (v) => setState(() => _autoStartBreaks = v),
          title: Text(tt(_selectedLang, "Molayı otomatik başlat", "Auto start breaks")),
          contentPadding: EdgeInsets.zero,
        ),
        SwitchListTile.adaptive(
          value: _autoStartNextFocus,
          onChanged: (v) => setState(() => _autoStartNextFocus = v),
          title: Text(tt(_selectedLang, "Bir sonraki odak oturumunu otomatik başlat", "Auto start next focus")),
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  // ───────────────────── SOUND ─────────────────────

  Widget _soundToggles() {
    return Column(
      children: [
        SwitchListTile.adaptive(
          value: _alarmSound,
          onChanged: (v) => setState(() => _alarmSound = v),
          title: Text(tt(_selectedLang, "Oturum bitince ses çal", "Play alarm at end")),
          contentPadding: EdgeInsets.zero,
        ),
        SwitchListTile.adaptive(
          value: _tickingSound,
          onChanged: (v) => setState(() => _tickingSound = v),
          title: Text(tt(_selectedLang, "Tıkırtı sesi", "Ticking sound")),
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  // ───────────────────── THEME ─────────────────────

  Widget _themeRow() {
    return Row(
      children: FocusThemes.all.map((t) {
        final selected = t.type == _selectedTheme;

        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedTheme = t.type),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: selected ? Colors.white10 : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: selected ? Colors.white : Colors.white24,
                  width: selected ? 1.8 : 1,
                ),
              ),
              child: Column(
                children: [
                  Icon(Icons.circle, color: t.accent, size: 18),
                  const SizedBox(height: 4),
                  Text(
                    t.name,
                    style: const TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ───────────────────── LANGUAGE ─────────────────────

  Widget _languageRow() {
    Widget chip(String label, AppLanguage value) {
      final selected = _selectedLang == value;
      return Expanded(
        child: GestureDetector(
          onTap: () => setState(() => _selectedLang = value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            padding: const EdgeInsets.symmetric(vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: selected ? Colors.white10 : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: selected ? Colors.white : Colors.white24,
                width: selected ? 1.8 : 1,
              ),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : Colors.white70,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        chip("TR", AppLanguage.tr),
        chip("EN", AppLanguage.en),
      ],
    );
  }

  // ───────────────────── SAVE BUTTON ─────────────────────

  Widget _saveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.theme.accent,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        onPressed: () {
          widget.onApply(
            _selectedTheme,
            TimerConfig(
              focusMinutes: _focus.round(),
              shortBreakMinutes: _shortB.round(),
              longBreakMinutes: _longB.round(),
            ),
            _selectedLang,
            _autoStartBreaks,
            _autoStartNextFocus,
            _tickingSound,
            _alarmSound,
          );
          Navigator.pop(context);
        },
        child: Text(
          tt(_selectedLang, "Kaydet", "Save"),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
