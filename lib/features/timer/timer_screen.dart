import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'timer_service.dart';
import '../settings/settings_provider.dart';
import '../../core/widgets/glass_box.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  String _getMotivationQuote(SettingsProvider settings) {
    final quotes = [
      settings.translate('quoteMotivation1'),
      settings.translate('quoteMotivation2'),
      settings.translate('quoteMotivation3'),
      settings.translate('quoteMotivation4'),
      settings.translate('quoteMotivation5'),
      settings.translate('quoteMotivation6'),
      settings.translate('quoteMotivation7'),
    ];
    return quotes[DateTime.now().day % quotes.length];
  }

  @override
  Widget build(BuildContext context) {
    final timer = Provider.of<TimerService>(context);
    final settings = Provider.of<SettingsProvider>(context); // Listen for language changes
    final theme = Theme.of(context);

    // Dynamic Colors based on mode
    Color progressColor;
    String statusText;
    
    switch (timer.mode) {
      case TimerMode.pomodoro:
        // Use Theme Primary Color for Focus
        progressColor = theme.colorScheme.primary; 
        statusText = settings.translate('focusTime');
        break;
      case TimerMode.shortBreak:
        // Use Theme Secondary Color for Breaks
        progressColor = theme.colorScheme.secondary;
        statusText = settings.translate('shortBreak');
        break;
      case TimerMode.longBreak:
        progressColor = theme.colorScheme.secondary;
        statusText = settings.translate('longBreak');
        break;
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Check for landscape
            if (constraints.maxWidth > constraints.maxHeight) {
              return _buildLandscapeLayout(context, timer, theme, progressColor, statusText, settings);
            }
            return _buildPortraitLayout(context, constraints, timer, theme, progressColor, statusText, settings);
          },
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(BuildContext context, BoxConstraints constraints, TimerService timer, ThemeData theme, Color progressColor, String statusText, SettingsProvider settings) {
    // Calculate adaptive radius based on the parent constraints (SafeArea size)
    // We want the timer to take up available space but not exceed a max size
    // Total static vertical occupancy approx 320-350 logical pixels
    
    double availableHeight = constraints.maxHeight - 320; 
    if (availableHeight < 150) availableHeight = 150;

    double availableWidth = constraints.maxWidth;
    
    // Calculate radius
    double maxRadiusHeight = availableHeight / 2;
    double maxRadiusWidth = availableWidth * 0.45; // 90% of width / 2
    
    double radius = min(maxRadiusWidth, maxRadiusHeight);
    
    // Bounds check
    radius = max(120.0, radius); // Minimum size
    radius = min(radius, 300.0); // Maximum size cap

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          _buildModeSwitcher(context, timer, settings),
          const Spacer(),
          _buildCircularTimer(context, timer, theme, progressColor, statusText, 
            radius,
            lineWidth: radius > 180 ? 25.0 : 18.0,
          ),
          const Spacer(),
          _buildControls(context, timer, theme, progressColor, settings),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              _getMotivationQuote(settings),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(flex: 2),
          const SizedBox(height: 80), // Bottom padding for nav bar
        ],
      ),
    );
  }

  Widget _buildLandscapeLayout(BuildContext context, TimerService timer, ThemeData theme, Color progressColor, String statusText, SettingsProvider settings) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center, // Align to center
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   _buildModeSwitcher(context, timer, settings),
                   const SizedBox(height: 30),
                   _buildCircularTimer(context, timer, theme, progressColor, statusText, 
                     MediaQuery.of(context).size.shortestSide >= 600 ? 220.0 : 120.0,
                     lineWidth: MediaQuery.of(context).size.shortestSide >= 600 ? 25.0 : 18.0,
                   ),
                ],
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildControls(context, timer, theme, progressColor, settings),
                  const SizedBox(height: 20),
                  Text(
                    _getMotivationQuote(settings),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 80), // Prevent overlap with bottom nav in landscape
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeSwitcher(BuildContext context, TimerService timer, SettingsProvider settings) {
    return GlassBox(
      height: 60,
      borderRadius: BorderRadius.circular(30),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ModeButton(title: settings.translate('focusShort'), mode: TimerMode.pomodoro, isSelected: timer.mode == TimerMode.pomodoro),
          _ModeButton(title: settings.translate('shortBreakShort'), mode: TimerMode.shortBreak, isSelected: timer.mode == TimerMode.shortBreak),
          _ModeButton(title: settings.translate('longBreakShort'), mode: TimerMode.longBreak, isSelected: timer.mode == TimerMode.longBreak),
        ],
      ),
    );
  }

  Widget _buildCircularTimer(BuildContext context, TimerService timer, ThemeData theme, Color progressColor, String statusText, double radius, {double lineWidth = 18.0}) {
    return CircularPercentIndicator(
      radius: radius,
      lineWidth: lineWidth,
      animation: true,
      animateFromLastPercent: true,
      percent: timer.progress,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            statusText,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            timer.timeString,
            style: theme.textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: radius * 0.45,
            ),
          ),
          if (timer.activeTaskTitle != null && timer.activeTaskTitle!.isNotEmpty) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                timer.activeTaskTitle!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: theme.colorScheme.onSurface.withValues(alpha: 0.1),
      progressColor: progressColor,
      backgroundWidth: 10,
    );
  }

  Widget _buildControls(BuildContext context, TimerService timer, ThemeData theme, Color? progressColor, SettingsProvider settings) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ControlButton(
          icon: Icons.refresh,
          onTap: timer.stop,
          color: theme.iconTheme.color,
        ),
        const SizedBox(width: 30),
        _ControlButton(
          icon: timer.status == TimerStatus.running ? Icons.pause : Icons.play_arrow,
          onTap: timer.status == TimerStatus.running ? timer.pause : timer.start,
          isMain: true,
          color: progressColor,
        ),
        const SizedBox(width: 30),
        _ControlButton(
          icon: Icons.skip_next,
          onTap: () {
            if (timer.status == TimerStatus.running) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(settings.translate('timerRunningWarning'))),
              );
              return;
            }
            if(timer.mode == TimerMode.pomodoro) {
              timer.setMode(TimerMode.shortBreak);
            } else if (timer.mode == TimerMode.shortBreak) {
              timer.setMode(TimerMode.longBreak);
            } else {
              timer.setMode(TimerMode.pomodoro);
            }
          },
          color: theme.iconTheme.color,
        ),
      ],
    );
  }
}

class _ModeButton extends StatelessWidget {
  final String title;
  final TimerMode mode;
  final bool isSelected;

  const _ModeButton({required this.title, required this.mode, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque, // Fix touch target ambiguity
        onTap: () {
          final timer = Provider.of<TimerService>(context, listen: false);
          final settings = Provider.of<SettingsProvider>(context, listen: false);
          
          if (timer.status == TimerStatus.running) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(settings.translate('timerRunningWarning'))),
            );
            return;
          }
          timer.setMode(mode);
        },
        child: AnimatedContainer(
          margin: const EdgeInsets.symmetric(horizontal: 2), // Slight separation
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).colorScheme.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
            ),
          ),
        ),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isMain;
  final Color? color;

  const _ControlButton({required this.icon, required this.onTap, this.isMain = false, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassBox(
        width: isMain ? 90 : 60,
        height: isMain ? 90 : 60,
        borderRadius: BorderRadius.circular(isMain ? 45 : 30),
        color: isMain ? color?.withValues(alpha: 0.2) : null,
        child: Icon(
          icon,
          size: isMain ? 40 : 28,
          color: isMain ? color : Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}
