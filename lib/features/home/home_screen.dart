import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../timer/timer_screen.dart';
import '../tasks/tasks_screen.dart';
import '../stats/stats_screen.dart';
import '../settings/settings_screen.dart';
import '../settings/settings_provider.dart';
import '../settings/rate_app_dialog.dart';
import '../timer/timer_service.dart';
import '../tasks/task_provider.dart';
import '../stats/history_provider.dart';
import '../../core/widgets/glass_box.dart';
import '../../core/widgets/background_animator.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Show rating dialog after settings load on first launch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RateAppDialog.showIfNeeded(context);
    });
  }

  // Use a getter or build method to ensure screens rebuild when dependencies (like Lang) change
  List<Widget> get _screens => [
    const TimerScreen(),
    TasksScreen(onNavigationRequest: () => setState(() => _currentIndex = 0)),
    const StatsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Listen to SettingsProvider to trigger rebuild on language change
    final settings = Provider.of<SettingsProvider>(context);

    // Initialize Timer Callback for Task Increment
    final timerService = Provider.of<TimerService>(context, listen: false); 
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final historyProvider = Provider.of<HistoryProvider>(context, listen: false);

    timerService.onPomodoroComplete = (taskId) {
      if (taskId != null) {
        taskProvider.incrementPomodoro(taskId);
        
        // Check if task is completed
        try {
          final task = taskProvider.tasks.firstWhere((t) => t.id == taskId);
          
          // LOG HISTORY
          historyProvider.logSession(
            settings.pomodoroMinutes, 
            task.title,
            settings.dailyGoalMinutes,
          );

          // Log completed task if task just got completed
          if (task.isCompleted) {
            historyProvider.logCompletedTask(task.title);
            timerService.setActiveTask(null, null); // Clear active task from timer
          }
        } catch (e) {
          // Task might have been deleted
        }
      } else {
        // Log generic session for plain Pomodoro
        historyProvider.logSession(
          settings.pomodoroMinutes, 
          settings.translate('generalFocus'),
          settings.dailyGoalMinutes,
        );
      }
    };

    return BackgroundAnimator(
      child: Scaffold(
        resizeToAvoidBottomInset: false, // Prevent keyboard from pushing up background
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Base Gradient (Bottom Layer)
            // Base Background (Gradient or Solid)
            Builder(
              builder: (context) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
                        Theme.of(context).primaryColor.withValues(alpha: 0.1),
                      ],
                    ),
                  ),
                );
              }
            ),

            
            // Current Screen Content
            // We use IndexedStack to preserve state or just switch? 
            // Switching is better for "Settings" to refresh language immediately.
            SafeArea(
              bottom: false, // We handle bottom padding for nav bar manually or via padding
              child: _screens[_currentIndex],
            ),

            // Gradient Fade for Bottom Nav
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 100, // Height of the fade area
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.0),
                        Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.8),
                        Theme.of(context).scaffoldBackgroundColor,
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Custom Floating Bottom Navigation
            Positioned(
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).padding.bottom + 10, // Dynamic bottom padding
                child: GlassBox(
                blur: 10, // Back to soft blur
                opacity: 0.1, // Back to transparent/sleek look
                height: 65, 
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                borderRadius: BorderRadius.circular(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(0, CupertinoIcons.timer, settings.translate('navFocus')),
                    _buildNavItem(1, CupertinoIcons.check_mark_circled, settings.translate('navTasks')),
                    _buildNavItem(2, CupertinoIcons.graph_square, settings.translate('navStats')),
                    _buildNavItem(3, CupertinoIcons.settings, settings.translate('navSettings')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    final color = isSelected 
        ? Theme.of(context).colorScheme.secondary 
        : Theme.of(context).iconTheme.color?.withValues(alpha: 0.5) ?? Colors.grey;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        color: Colors.transparent, // Hit test target
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: 28,
            ),
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 5, spreadRadius: 1)
                  ]
                ),
              ),
          ],
        ),
      ),
    );
  }
}
