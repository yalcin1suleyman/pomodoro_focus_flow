import 'package:flutter/material.dart';

import '../../../models/theme_models.dart';
import '../../../models/timer_models.dart';
import '../../../core/localization/app_language.dart';

// BURADA enum AppLanguage ve tt(...) TANIMI OLMAYACAK

/// Ana ekrana geri dönerken kullanılacak sonuç modeli
class SettingsResult {
  final FocusThemeType themeType;
  final TimerConfig config;
  final AppLanguage language;
  final bool autoStartBreaks;
  final bool autoStartNextFocus;
  final bool tickingSound;
  final bool alarmSound;
  final double alarmVolume;
  final double tickVolume;
  final bool useSystemNotification; // 🔔 YENİ: Uygulama sesi mi, sistem bildirimi mi?

  SettingsResult({
    required this.themeType,
    required this.config,
    required this.language,
    required this.autoStartBreaks,
    required this.autoStartNextFocus,
    required this.tickingSound,
    required this.alarmSound,
    required this.alarmVolume,
    required this.tickVolume,
    required this.useSystemNotification,
  });
}

class SettingsPage extends StatefulWidget {
  final FocusTheme theme;
  final TimerConfig config;
  final AppLanguage language;

  final bool autoStartBreaks;
  final bool autoStartNextFocus;
  final bool tickingSound;
  final bool alarmSound;

  /// true: telefonun sistem bildirimi kullanılacak
  /// false: uygulama içi ses dosyası (ses1.wav) kullanılacak
  final bool useSystemNotification;

  /// Uygulama içi alarm sesini önizlemek için (home_page'den fonksiyon geçeceğiz)
  final VoidCallback? onPreviewAlarm;

  const SettingsPage({
    super.key,
    required this.theme,
    required this.config,
    required this.language,
    required this.autoStartBreaks,
    required this.autoStartNextFocus,
    required this.tickingSound,
    required this.alarmSound,
    required this.useSystemNotification,
    this.onPreviewAlarm,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late FocusThemeType _selectedTheme;
  late AppLanguage _selectedLang;

  late double _focus;
  late double _shortB;
  late double _longB;

  late bool _autoStartBreaks;
  late bool _autoStartNextFocus;
  late bool _tickingSound;
  late bool _alarmSound;

  late bool _useSystemNotification; // 🔔 state içinde tutulacak

  // Ses için basit volume ayarları (ileride gerçek sesle bağlanabilir)
  double _alarmVolume = 0.7;
  double _tickVolume = 0.5;

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
    _useSystemNotification = widget.useSystemNotification;
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;

    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        backgroundColor: const Color(0xFF020617),
        elevation: 0,
        title: Text(
          tt(_selectedLang, "Ayarlar", "Settings"),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    _timerSectionCard(theme),
                    const SizedBox(height: 12),
                    _soundSectionCard(theme),
                    const SizedBox(height: 12),
                    _themeSectionCard(theme),
                    const SizedBox(height: 12),
                    _languageSectionCard(theme),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.accent,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  onPressed: _onSavePressed,
                  child: Text(
                    tt(_selectedLang, "Kaydet", "Save"),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ───────────────────── SÜRE AYARLARI ─────────────────────

  Widget _timerSectionCard(FocusTheme theme) {
    return _SettingsSection(
      icon: Icons.timer_outlined,
      title: tt(_selectedLang, "Süre Ayarları", "Timer"),
      subtitle: "${_focus.round()} • ${_shortB.round()} • ${_longB.round()}",
      child: Column(
        children: [
          _sliderRow(
            tt(_selectedLang, "Pomodoro", "Pomodoro"),
            _focus,
            10,
            180,
            theme,
            onChanged: (v) => setState(() => _focus = v),
          ),
          const SizedBox(height: 8),
          _sliderRow(
            tt(_selectedLang, "Kısa Mola", "Short Break"),
            _shortB,
            3,
            30,
            theme,
            onChanged: (v) => setState(() => _shortB = v),
          ),
          const SizedBox(height: 8),
          _sliderRow(
            tt(_selectedLang, "Uzun Mola", "Long Break"),
            _longB,
            0,
            60,
            theme,
            onChanged: (v) => setState(() => _longB = v),
          ),
          const Divider(height: 24),
          SwitchListTile.adaptive(
            value: _autoStartBreaks,
            onChanged: (v) => setState(() => _autoStartBreaks = v),
            title: Text(
              tt(
                _selectedLang,
                "Pomodoro bittiğinde molayı otomatik başlat",
                "Auto start break after pomodoro",
              ),
            ),
            contentPadding: EdgeInsets.zero,
          ),
          SwitchListTile.adaptive(
            value: _autoStartNextFocus,
            onChanged: (v) => setState(() => _autoStartNextFocus = v),
            title: Text(
              tt(
                _selectedLang,
                "Mola bittiğinde bir sonraki Pomodoro'yu başlat",
                "Auto start next pomodoro after break",
              ),
            ),
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _sliderRow(
      String title,
      double value,
      double min,
      double max,
      FocusTheme theme, {
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
          activeColor: theme.accent,
          inactiveColor: Colors.white24,
          onChanged: onChanged,
        ),
      ],
    );
  }

  // ───────────────────── SES AYARLARI ─────────────────────

  Widget _soundSectionCard(FocusTheme theme) {
    return _SettingsSection(
      icon: Icons.music_note_outlined,
      title: tt(_selectedLang, "Ses Ayarları", "Sound"),
      subtitle: _soundSubtitle(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Alarm açık / kapalı
          SwitchListTile.adaptive(
            value: _alarmSound,
            onChanged: (v) => setState(() => _alarmSound = v),
            title: Text(
              tt(
                _selectedLang,
                "Oturum bittiğinde alarm çal",
                "Play alarm sound when session ends",
              ),
            ),
            contentPadding: EdgeInsets.zero,
          ),
          if (_alarmSound) ...[
            const SizedBox(height: 4),
            Text(
              tt(_selectedLang, "Alarm sesi yüksekliği", "Alarm volume"),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
            Slider(
              value: _alarmVolume,
              min: 0.0,
              max: 1.0,
              activeColor: theme.accent,
              inactiveColor: Colors.white24,
              onChanged: (v) => setState(() => _alarmVolume = v),
            ),
            const SizedBox(height: 8),

            // 🔔 Zil tipi seçimi: Uygulama zili / Telefon bildirimi
            Text(
              tt(
                _selectedLang,
                "Zil türü",
                "Alarm type",
              ),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            RadioListTile<bool>(
              value: false,
              groupValue: _useSystemNotification,
              onChanged: (v) {
                if (v == null) return;
                setState(() => _useSystemNotification = v);
              },
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text(
                tt(
                  _selectedLang,
                  "Uygulama içi zil sesi (ses1.wav)",
                  "In-app alarm sound (ses1.wav)",
                ),
                style: const TextStyle(fontSize: 13),
              ),
            ),
            RadioListTile<bool>(
              value: true,
              groupValue: _useSystemNotification,
              onChanged: (v) {
                if (v == null) return;
                setState(() => _useSystemNotification = v);
              },
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text(
                tt(
                  _selectedLang,
                  "Telefon bildirimi (sistem sesi)",
                  "System notification sound",
                ),
                style: const TextStyle(fontSize: 13),
              ),
            ),
            const SizedBox(height: 4),

            // 🔊 Uygulama zilini dene butonu (sadece in-app seçiliyse mantıklı)
            if (!_useSystemNotification && widget.onPreviewAlarm != null)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: widget.onPreviewAlarm,
                  icon: const Icon(Icons.volume_up, size: 16),
                  label: Text(
                    tt(
                      _selectedLang,
                      "Zili dinle",
                      "Preview alarm",
                    ),
                    style: const TextStyle(fontSize: 13),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                  ),
                ),
              ),
          ],

          const Divider(height: 24),

          // Tıkırtı sesi
          SwitchListTile.adaptive(
            value: _tickingSound,
            onChanged: (v) => setState(() => _tickingSound = v),
            title: Text(
              tt(
                _selectedLang,
                "Odaklanırken tıkırtı sesi",
                "Ticking sound while focusing",
              ),
            ),
            contentPadding: EdgeInsets.zero,
          ),
          if (_tickingSound) ...[
            const SizedBox(height: 4),
            Text(
              tt(_selectedLang, "Tıkırtı sesi yüksekliği", "Tick volume"),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
            Slider(
              value: _tickVolume,
              min: 0.0,
              max: 1.0,
              activeColor: theme.accent,
              inactiveColor: Colors.white24,
              onChanged: (v) => setState(() => _tickVolume = v),
            ),
          ],
          const SizedBox(height: 6),
          Text(
            tt(
              _selectedLang,
              "Sesler şu an sadece uygulama içi ayarlar olarak tutuluyor. İleride bildirim ve gerçek seslerle bağlayabilirsin.",
              "Sounds are kept as in-app settings for now. Later you can hook them to real audio/notifications.",
            ),
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }

  String _soundSubtitle() {
    if (_alarmSound && _tickingSound) {
      return tt(_selectedLang, "Alarm + tıkırtı açık", "Alarm + ticking on");
    }
    if (_alarmSound) {
      return tt(_selectedLang, "Sadece alarm açık", "Alarm on");
    }
    if (_tickingSound) {
      return tt(_selectedLang, "Sadece tıkırtı açık", "Ticking on");
    }
    return tt(_selectedLang, "Sessiz mod", "Silent");
  }

  // ───────────────────── TEMA ─────────────────────

  Widget _themeSectionCard(FocusTheme theme) {
    return _SettingsSection(
      icon: Icons.palette_outlined,
      title: tt(_selectedLang, "Tema", "Theme"),
      subtitle:
      FocusThemes.all.firstWhere((t) => t.type == _selectedTheme).name,
      child: Row(
        children: FocusThemes.all.map((t) {
          final selected = t.type == _selectedTheme;

          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTheme = t.type),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                padding: const EdgeInsets.symmetric(vertical: 12),
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
      ),
    );
  }

  // ───────────────────── DİL ─────────────────────

  Widget _languageSectionCard(FocusTheme theme) {
    return _SettingsSection(
      icon: Icons.language_outlined,
      title: tt(_selectedLang, "Dil", "Language"),
      subtitle: _selectedLang == AppLanguage.tr ? "Türkçe" : "English",
      child: Row(
        children: [
          _languageChip("TR", AppLanguage.tr),
          const SizedBox(width: 8),
          _languageChip("EN", AppLanguage.en),
        ],
      ),
    );
  }

  Widget _languageChip(String label, AppLanguage value) {
    final selected = _selectedLang == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedLang = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(vertical: 10),
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

  // ───────────────────── SAVE ─────────────────────

  void _onSavePressed() {
    final result = SettingsResult(
      themeType: _selectedTheme,
      config: TimerConfig(
        focusMinutes: _focus.round(),
        shortBreakMinutes: _shortB.round(),
        longBreakMinutes: _longB.round(),
      ),
      language: _selectedLang,
      autoStartBreaks: _autoStartBreaks,
      autoStartNextFocus: _autoStartNextFocus,
      tickingSound: _tickingSound,
      alarmSound: _alarmSound,
      alarmVolume: _alarmVolume,
      tickVolume: _tickVolume,
      useSystemNotification: _useSystemNotification, // 🔔 önemli
    );

    Navigator.pop(context, result);
  }
}

/// Ortak bölüm kartı
class _SettingsSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget child;

  const _SettingsSection({
    required this.icon,
    required this.title,
    required this.child,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF020617),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Colors.white12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          childrenPadding:
          const EdgeInsets.fromLTRB(16, 0, 16, 16),
          leading: Icon(icon, size: 22),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: subtitle == null
              ? null
              : Text(
            subtitle!,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
          children: [child],
        ),
      ),
    );
  }
}
