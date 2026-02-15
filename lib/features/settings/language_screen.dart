import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart';
import '../../core/widgets/glass_box.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final languages = settings.supportedLanguages;

    return Scaffold(
      backgroundColor: Colors.transparent, // Uses background from main scaffold
      appBar: AppBar(
        title: Text(settings.translate('language')),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          itemCount: languages.length,
          itemBuilder: (context, index) {
            final lang = languages[index];
            final isSelected = settings.language == lang.code;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: GlassBox(
                padding: EdgeInsets.zero,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  leading: Text(
                    _getFlag(lang.code),
                    style: const TextStyle(fontSize: 24),
                  ),
                  title: Text(
                    lang.name,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Theme.of(context).primaryColor : null,
                    ),
                  ),
                  trailing: isSelected 
                      ? Icon(Icons.check_circle, color: Theme.of(context).primaryColor)
                      : null,
                  onTap: () {
                    settings.setLanguage(lang.code);
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _getFlag(String code) {
    switch (code) {
      case 'en': return '🇺🇸';
      case 'tr': return '🇹🇷';
      case 'es': return '🇪🇸';
      case 'pt': return '🇵🇹';
      case 'de': return '🇩🇪';
      case 'fr': return '🇫🇷';
      case 'it': return '🇮🇹';
      case 'ru': return '🇷🇺';
      case 'ja': return '🇯🇵';
      case 'ko': return '🇰🇷';
      case 'zh': return '🇨🇳';
      case 'hi': return '🇮🇳';
      case 'ar': return '🇸🇦';
      case 'id': return '🇮🇩';
      case 'vi': return '🇻🇳';
      case 'bn': return '🇧🇩';
      case 'ur': return '🇵🇰';
      case 'pl': return '🇵🇱';
      case 'th': return '🇹🇭';
      case 'nl': return '🇳🇱';
      case 'uk': return '🇺🇦';
      case 'el': return '🇬🇷';
      case 'sv': return '🇸🇪';
      default: return '🏳️';
    }
  }
}
