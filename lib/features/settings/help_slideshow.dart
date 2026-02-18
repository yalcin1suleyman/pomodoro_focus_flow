import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart';
import '../../core/widgets/glass_box.dart';

class HelpSlideshow extends StatefulWidget {
  const HelpSlideshow({super.key});

  @override
  State<HelpSlideshow> createState() => _HelpSlideshowState();
}

class _HelpSlideshowState extends State<HelpSlideshow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _slides = [
    {
      'image': 'assets/images/help_intro.png', // Placeholder
      'titleKey': 'helpSlide1Title',
      'descKey': 'helpSlide1Desc',
    },
    {
      'image': 'assets/images/help_plan.png',
      'titleKey': 'helpSlide2Title',
      'descKey': 'helpSlide2Desc',
    },
    {
      'image': 'assets/images/help_focus.png',
      'titleKey': 'helpSlide3Title',
      'descKey': 'helpSlide3Desc',
    },
    {
      'image': 'assets/images/help_break.png',
      'titleKey': 'helpSlide4Title',
      'descKey': 'helpSlide4Desc',
    },
    {
      'image': 'assets/images/help_cycle.png',
      'titleKey': 'helpSlide5Title',
      'descKey': 'helpSlide5Desc',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar: Skip Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_currentPage < _slides.length - 1)
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        settings.translate('skip'),
                        style: TextStyle(
                          color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                          fontSize: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            // Content: PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image
                        Expanded(
                          flex: 3,
                          child: Container(
                            alignment: Alignment.center,
                            child: Image.asset(
                              slide['image']!,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                // Fallback icon if image missing
                                IconData icon;
                                switch(index) {
                                  case 0: icon = Icons.timer; break;
                                  case 1: icon = Icons.track_changes; break;
                                  case 2: icon = Icons.center_focus_strong; break;
                                  case 3: icon = Icons.coffee; break;
                                  case 4: icon = Icons.loop; break;
                                  default: icon = Icons.help;
                                }
                                return Icon(
                                  icon, 
                                  size: 100, 
                                  color: theme.colorScheme.primary.withOpacity(0.5)
                                );
                              },
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // Text
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Text(
                                settings.translate(slide['titleKey']!),
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                settings.translate(slide['descKey']!),
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // Bottom Control Area
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page Indicators
                  Row(
                    children: List.generate(
                      _slides.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 8),
                        height: 8,
                        width: _currentPage == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index 
                              ? theme.colorScheme.primary 
                              : theme.colorScheme.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  
                  // Next/Start Button
                  GlassBox(
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      onTap: _nextPage,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _currentPage == _slides.length - 1 
                                  ? settings.translate('start') 
                                  : settings.translate('next'),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              _currentPage == _slides.length - 1 
                                  ? Icons.check 
                                  : Icons.arrow_forward,
                              size: 18,
                              color: theme.colorScheme.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
