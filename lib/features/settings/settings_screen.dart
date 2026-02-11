import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart';
import '../stats/history_provider.dart';
import '../../core/widgets/glass_box.dart';
import '../../core/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                settings.translate('settings'),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              
              // Appearance Section
              _buildSectionHeader(context, settings.translate('appearance')),
              GlassBox(
                child: Column(
                  children: [
                    // Language
                     ListTile(
                      title: Text(settings.translate('language')),
                      leading: const Icon(Icons.language),
                      trailing: DropdownButton<String>(
                        value: settings.language,
                        underline: const SizedBox(),
                        dropdownColor: Theme.of(context).cardColor,
                        onChanged: (String? newValue) {
                          if (newValue != null) settings.setLanguage(newValue);
                        },
                        items: const [
                          DropdownMenuItem(value: 'en', child: Text("English")),
                          DropdownMenuItem(value: 'tr', child: Text("Türkçe")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),

              // Theme Selector
              _buildSectionHeader(context, settings.translate('theme')),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildThemeCard(context, settings, AppThemeType.defaultTheme, settings.translate('themeDefault'), AppColors.primaryLight),
                    _buildThemeCard(context, settings, AppThemeType.sakura, settings.translate('themeSakura'), AppColors.sakuraPrimary),
                    _buildThemeCard(context, settings, AppThemeType.ocean, settings.translate('themeOcean'), AppColors.oceanPrimary),
                    _buildThemeCard(context, settings, AppThemeType.forest, settings.translate('themeForest'), AppColors.forestPrimary),
                    _buildThemeCard(context, settings, AppThemeType.luxury, settings.translate('themeLuxury'), AppColors.luxuryPrimary),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Goals Section
              _buildSectionHeader(context, settings.translate('dailyGoal')),
              GlassBox(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(settings.translate('dailyGoal'), style: const TextStyle(fontWeight: FontWeight.w600)),
                        Text(
                          "${(settings.dailyGoalMinutes / 60).toStringAsFixed(1)} ${settings.translate('hours')}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: settings.dailyGoalMinutes.toDouble(),
                      min: 30,
                      max: 600, // 10 hours
                      divisions: 19,
                      label: "${(settings.dailyGoalMinutes / 60).toStringAsFixed(1)} h",
                      onChanged: (val) {
                        settings.setDailyGoal(val.toInt());
                        Provider.of<HistoryProvider>(context, listen: false).updateDailyGoal(DateTime.now(), val.toInt());
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Timer Settings Section
              _buildSectionHeader(context, settings.translate('timerSettings')),
              GlassBox(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    _buildDurationInput(context, settings, 'pomodoro', settings.translate('pomodoroDuration'), settings.pomodoroMinutes),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    _buildDurationInput(context, settings, 'short', settings.translate('shortBreakDuration'), settings.shortBreakMinutes),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    _buildDurationInput(context, settings, 'long', settings.translate('longBreakDuration'), settings.longBreakMinutes),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Sound Section
              // Sound Section
              _buildSectionHeader(context, settings.translate('focusSounds')),
              GlassBox(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: _buildTypeOption(context, settings, "bell", settings.translate('soundTypeBell'), Icons.music_note)),
                        const SizedBox(width: 10),
                        Expanded(child: _buildTypeOption(context, settings, "notification", settings.translate('soundTypeNotification'), Icons.notifications_active)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    Text(
                      "Pomodoro Master",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Yalcin Studio",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${settings.translate('version')} 1.1.0",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80), // Space for bottom nav
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
        ),
      ),
    );
  }

  Widget _buildThemeCard(BuildContext context, SettingsProvider settings, AppThemeType type, String label, Color color) {
    final isSelected = settings.currentTheme == type;
    return GestureDetector(
      onTap: () => settings.setTheme(type),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        width: 80,
        height: 100,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
          border: isSelected ? Border.all(color: color, width: 2) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(backgroundColor: color, radius: 15),
            const SizedBox(height: 10),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            if(isSelected) Icon(Icons.check_circle, color: color, size: 16)
          ],
        ),
      ),
    );
  }

  Widget _buildDurationInput(BuildContext context, SettingsProvider settings, String type, String label, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
        SizedBox(
          width: 90,
          child: TextFormField(
            initialValue: value.toString(),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              filled: true,
              fillColor: Theme.of(context).cardColor.withOpacity(0.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5),
              ),
              suffixText: settings.translate("minutes").substring(0, 2), // "mi" or "da" (assuming 'min'/'dk' roughly)
              suffixStyle: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.5)),
            ),
            onChanged: (val) {
              if (val.isNotEmpty) {
                 final intVal = int.tryParse(val);
                 if (intVal != null && intVal > 0) {
                   settings.setTimerDuration(type, intVal);
                 }
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTypeOption(BuildContext context, SettingsProvider settings, String type, String label, IconData icon) {
    final isSelected = settings.soundType == type;
    final primaryColor = Theme.of(context).colorScheme.primary;
    
    return InkWell(
      onTap: () => settings.setSoundType(type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: isSelected ? Border.all(color: primaryColor) : Border.all(color: Colors.grey.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: isSelected ? primaryColor : Colors.grey),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? primaryColor : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
