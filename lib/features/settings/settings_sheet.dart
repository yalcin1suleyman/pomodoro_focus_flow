import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/theme_models.dart';
import '../../models/timer_models.dart';

enum AppLanguage { tr, en }

/// Dil çevirisi yardımcı fonksiyon
String tt(AppLanguage lang, String tr, String en) =>
    lang == AppLanguage.tr ? tr : en;

/// Preset modeli
class FocusPreset {
  final String nameTR;
  final String nameEN;
  final IconData icon;
  final int focus;
  final int shortBreak;
  final int longBreak;

  const FocusPreset({
    required this.nameTR,
    required this.nameEN,
    required this.icon,
    required this.focus,
    required this.shortBreak,
    required this.longBreak,
  });
}

/// Bilimsel preset listesi (6 adet / simetrik grid)
const List<FocusPreset> presetList = [
  FocusPreset(
    nameTR: "Mini",
    nameEN: "Mini",
    icon: Icons.bolt_rounded,
    focus: 10,
    shortBreak: 3,
    longBreak: 3,
  ),
  FocusPreset(
    nameTR: "Klasik",
    nameEN: "Classic",
    icon: Icons.timer_rounded,
    focus: 25,
    shortBreak: 5,
    longBreak: 15,
  ),
  FocusPreset(
    nameTR: "Derin Çalışma",
    nameEN: "Deep Work",
    icon: Icons.auto_awesome_rounded,
    focus: 50,
    shortBreak: 10,
    longBreak: 15,
  ),
  FocusPreset(
    nameTR: "52 / 17",
    nameEN: "52 / 17",
    icon: Icons.bar_chart_rounded,
    focus: 52,
    shortBreak: 17,
    longBreak: 0,
  ),
  FocusPreset(
    nameTR: "Ultradian",
    nameEN: "Ultradian",
    icon: Icons.bedtime_rounded,
    focus: 90,
    shortBreak: 20,
    longBreak: 20,
  ),
  FocusPreset(
    nameTR: "Özel",
    nameEN: "Special",
    icon: Icons.star_rounded,
    focus: 25,
    shortBreak: 5,
    longBreak: 15,
  ),
];

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

  double _focus = 25;
  double _shortB = 5;
  double _longB = 15;

  String activePreset = "Classic"; // varsayılan

  bool slidersEnabled = false; // preset seçilirse kapalı, Special seçilirse açık

  @override
  void initState() {
    super.initState();
    _selectedTheme = widget.theme.type;
    _selectedLang = widget.language;

    _focus = widget.config.focusMinutes.toDouble();
    _shortB = widget.config.shortBreakMinutes.toDouble();
    _longB = widget.config.longBreakMinutes.toDouble();

    _loadSpecialMod();
  }

  // --------------------------------------------------------------------------
  //      SPECIAL MODU YÜKLE (KALICI)
  // --------------------------------------------------------------------------
  Future<void> _loadSpecialMod() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool("special_active") ?? false) {
      activePreset = "Special";

      _focus = prefs.getInt("special_focus")?.toDouble() ?? _focus;
      _shortB = prefs.getInt("special_short")?.toDouble() ?? _shortB;
      _longB = prefs.getInt("special_long")?.toDouble() ?? _longB;

      slidersEnabled = true;

      setState(() {});
    }
  }

  Future<void> _saveSpecialMod() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool("special_active", true);
    await prefs.setInt("special_focus", _focus.round());
    await prefs.setInt("special_short", _shortB.round());
    await prefs.setInt("special_long", _longB.round());
  }

  Future<void> _clearSpecial() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("special_active");
  }

  // --------------------------------------------------------------------------
  //                                  BUILD
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final theming = widget.theme;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
        color: const Color(0xFF020617),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
            const SizedBox(height: 14),

            _label(tt(_selectedLang, "Hazır Modlar", "Focus Modes")),
            const SizedBox(height: 8),
            _presetGrid(),

            const SizedBox(height: 18),

            _label(tt(_selectedLang, "Tema", "Theme")),
            const SizedBox(height: 8),
            _themeRow(),

            const SizedBox(height: 18),

            _label(tt(_selectedLang, "Zamanlayıcı Süreleri", "Timer Durations")),
            const SizedBox(height: 8),

            _slider("Odak", _focus, 10, 180,
                badge: _focus == 25 ? "Klasik" : _focus >= 120 ? "Zen" : null,
                enabled: slidersEnabled,
                onChanged: (v) => setState(() => _focus = v)),
            const SizedBox(height: 8),

            _slider("Kısa Mola", _shortB, 3, 30,
                badge: _shortBadge(_shortB),
                enabled: slidersEnabled,
                onChanged: (v) => setState(() => _shortB = v)),
            const SizedBox(height: 8),

            _slider("Uzun Mola", _longB, 0, 60,
                badge: _longBadge(_longB),
                enabled: slidersEnabled,
                onChanged: (v) => setState(() => _longB = v)),

            const SizedBox(height: 26),
            _saveButton(theming),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  //                                HEADER
  // --------------------------------------------------------------------------
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
        )
      ],
    );
  }

  Widget _label(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text,
          style: const TextStyle(color: Colors.white70, fontSize: 13)),
    );
  }

  // --------------------------------------------------------------------------
  //                              PRESET GRID
  // --------------------------------------------------------------------------
  Widget _presetGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: presetList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 78,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      itemBuilder: (_, i) {
        final p = presetList[i];
        final displayName =
        _selectedLang == AppLanguage.tr ? p.nameTR : p.nameEN;

        final isSelected = activePreset == p.nameEN;

        return GestureDetector(
          onTap: () async {
            activePreset = p.nameEN;

            // Eğer Special değilse preset değerlerini uygula
            if (p.nameEN != "Special") {
              slidersEnabled = false;
              _focus = p.focus.toDouble();
              _shortB = p.shortBreak.toDouble();
              _longB = p.longBreak.toDouble();
              await _clearSpecial();

              // ANINDA UYGULA (modal kapanır)
              widget.onApply(
                _selectedTheme,
                TimerConfig(
                  focusMinutes: _focus.round(),
                  shortBreakMinutes: _shortB.round(),
                  longBreakMinutes: _longB.round(),
                ),
                _selectedLang,
              );

              Navigator.pop(context);
              return;
            }

            // SPECIAL MOD → slider açık kalır, kaydet gerekmeyecek
            slidersEnabled = true;

            // Eğer daha önce kayıtlı ise yükle
            await _loadSpecialMod();

            setState(() {});
          },

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white10 : Colors.white12.withOpacity(0.05),
              borderRadius: BorderRadius.circular(14), //
              border: Border.all(
                color: isSelected ? Colors.white : Colors.white24,
                width: isSelected ? 2 : 1,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(p.icon, size: 20, color: Colors.white),
                const SizedBox(height: 4),
                Text(
                  displayName,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  // --------------------------------------------------------------------------
  //                         SCIENTIFIC BADGES
  // --------------------------------------------------------------------------
  String _shortBadge(double v) {
    if (v <= 5) return "Micro Recharge";
    if (v <= 10) return "Balanced Reset";
    return "Extended Break";
  }

  String _longBadge(double v) {
    if (v <= 20) return "Light Recovery";
    if (v <= 30) return "Deep Recovery";
    return "Reboot";
  }

  // --------------------------------------------------------------------------
  //                                 SLIDER
  // --------------------------------------------------------------------------
  Widget _slider(String title, double value, double min, double max,
      {required bool enabled,
        required ValueChanged<double> onChanged,
        String? badge}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: const TextStyle(color: Colors.white70)),
            const Spacer(),
            if (badge != null)
              Text(badge,
                  style:
                  const TextStyle(color: Colors.pinkAccent, fontSize: 11)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(999)),
              child: Text(value.round().toString()),
            )
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          activeColor: Colors.pinkAccent,
          inactiveColor: Colors.white24,
          onChanged: enabled ? onChanged : null,
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  //                               THEME ROW
  // --------------------------------------------------------------------------
  Widget _themeRow() {
    return Row(
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
                borderRadius:
                BorderRadius.circular(16),
                border: Border.all(
                    color: selected ? Colors.white : Colors.white24),
              ),
              child: Column(
                children: [
                  Icon(Icons.circle, color: t.accent, size: 18),
                  const SizedBox(height: 4),
                  Text(t.name, style: const TextStyle(fontSize: 11)),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // --------------------------------------------------------------------------
  //                                SAVE BUTTON
  // --------------------------------------------------------------------------
  Widget _saveButton(FocusTheme ttheme) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ttheme.accent,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999)),
        ),
        onPressed: () async {
          // Sadece Special mod için kaydet
          if (activePreset == "Special") {
            await _saveSpecialMod();

            widget.onApply(
              _selectedTheme,
              TimerConfig(
                focusMinutes: _focus.round(),
                shortBreakMinutes: _shortB.round(),
                longBreakMinutes: _longB.round(),
              ),
              _selectedLang,
            );
          }

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
