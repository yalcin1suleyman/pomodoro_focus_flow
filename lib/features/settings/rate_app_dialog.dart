import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'settings_provider.dart';


class RateAppDialog extends StatelessWidget {
  const RateAppDialog({super.key});

  static Future<void> showIfNeeded(BuildContext context) async {
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    if (!settings.hasRatedApp) {
      await Future.delayed(const Duration(milliseconds: 800));
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => const RateAppDialog(),
        );
      }
    }
  }

  Future<void> _openPlayStore(BuildContext context) async {
    final settings = Provider.of<SettingsProvider>(context, listen: false);
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
    await settings.setHasRated();
    if (context.mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Star icon
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withValues(alpha: 0.12),
              ),
              child: Icon(Icons.star_rate_rounded, size: 40, color: primaryColor),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              settings.translate('rateAppTitle'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Message
            Text(
              settings.translate('rateAppMessage'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
            const SizedBox(height: 28),

            // Rate Now button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _openPlayStore(context),
                icon: const Icon(Icons.star_rate_rounded),
                label: Text(settings.translate('rateNow')),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Later button
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                settings.translate('rateLater'),
                style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
