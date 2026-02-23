import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart';
import '../stats/history_provider.dart';
import '../../core/widgets/glass_box.dart';
import '../../core/theme/app_theme.dart';
import 'language_screen.dart';
import '../../core/services/ad_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'help_slideshow.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  BannerAd? _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = AdService().createBannerAd()
      ..load().then((_) {
        setState(() {
          _isBannerAdReady = true;
        });
      });
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

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
              Row(
                children: [
                  Text(
                    settings.translate('settings'),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.help_outline),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HelpSlideshow()),
                      );
                    },
                  ),
                ],
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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            settings.currentLanguageObj.name,
                            style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                      onTap: () {
                         Navigator.push(
                           context, 
                           MaterialPageRoute(builder: (context) => const LanguageScreen())
                         );
                      },
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
                    _buildThemeCard(context, settings, AppThemeType.silver, settings.translate('themeSilver'), AppColors.silverPrimary),
                    _buildThemeCard(context, settings, AppThemeType.ocean, settings.translate('themeOcean'), AppColors.oceanPrimary),
                    _buildThemeCard(context, settings, AppThemeType.forest, settings.translate('themeForest'), AppColors.forestPrimary),
                    _buildThemeCard(context, settings, AppThemeType.classic, settings.translate('themeClassic'), AppColors.primaryLight),
                    _buildThemeCard(context, settings, AppThemeType.sakura, settings.translate('themeSakura'), AppColors.sakuraPrimary),
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
                      max: 720, // 12 hours
                      divisions: 23,
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

              const SizedBox(height: 30),

              // Rate & Contact Section
              _buildSectionHeader(context, 'Pomodoro Master'),
              GlassBox(
                child: Column(
                  children: [
                    // Rate the App
                    ListTile(
                      leading: Icon(
                        Icons.star_rate_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(settings.translate('rateApp')),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () async {
                        // Try market:// first (direct Play Store), fallback to https://
                        final marketUri = Uri.parse(
                          'market://details?id=com.yalcinstudio.pomodoro_master',
                        );
                        final webUri = Uri.parse(
                          'https://play.google.com/store/apps/details?id=com.yalcinstudio.pomodoro_master',
                        );
                        try {
                          await launchUrl(marketUri, mode: LaunchMode.externalApplication);
                        } catch (_) {
                          await launchUrl(webUri, mode: LaunchMode.externalApplication);
                        }
                      },
                    ),
                    const Divider(height: 1),
                    // Contact Us
                    ListTile(
                      leading: Icon(
                        Icons.email_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(settings.translate('contactUs')),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => _launchContactEmail(context, settings),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Logo & version area
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 60,
                      height: 60,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.timer_outlined, size: 50, color: Theme.of(context).colorScheme.primary);
                      },
                    ),
                    const SizedBox(height: 10),
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
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.withValues(alpha: 0.5)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Banner Ad
              if (_isBannerAdReady)
                Center(
                  child: SizedBox(
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd!),
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
          color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.7),
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
          color: color.withValues(alpha: 0.2),
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
              fillColor: Theme.of(context).cardColor.withValues(alpha: 0.5),
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
              suffixText: settings.translate("minutes"),
              suffixStyle: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.5)),
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
          color: isSelected ? primaryColor.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: isSelected ? Border.all(color: primaryColor) : Border.all(color: Colors.grey.withValues(alpha: 0.3)),
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

  Future<void> _launchContactEmail(BuildContext context, SettingsProvider settings) async {
    String deviceModel = 'Unknown';
    String osVersion = 'Unknown';
    String appVersion = 'Unknown';

    try {
      final packageInfo = await PackageInfo.fromPlatform();
      appVersion = '${packageInfo.version} (${packageInfo.buildNumber})';
    } catch (_) {}

    try {
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final info = await deviceInfo.androidInfo;
        deviceModel = '${info.manufacturer} ${info.model}';
        osVersion = 'Android ${info.version.release} (SDK ${info.version.sdkInt})';
      } else if (Platform.isIOS) {
        final info = await deviceInfo.iosInfo;
        deviceModel = info.utsname.machine;
        osVersion = '${info.systemName} ${info.systemVersion}';
      }
    } catch (_) {}

    final subject = Uri.encodeComponent('Pomodoro Master Kullanıcı Bildirimi');
    final body = Uri.encodeComponent(
      'Cihaz: $deviceModel\n'
      'İşletim Sistemi: $osVersion\n'
      'Uygulama Sürümü: $appVersion\n\n'
      '---\n'
      'Mesajınızı buraya yazın:\n',
    );

    final uri = Uri.parse('mailto:yalcinstudio@gmail.com?subject=$subject&body=$body');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

