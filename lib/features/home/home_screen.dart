import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../timer/timer_screen.dart';
import '../tasks/tasks_screen.dart';
import '../stats/stats_screen.dart';
import '../settings/settings_screen.dart';
import '../settings/settings_provider.dart';
import '../timer/timer_service.dart';
import '../tasks/task_provider.dart';
import '../stats/history_provider.dart';
import '../../core/widgets/glass_box.dart';
import '../../core/widgets/background_animator.dart';
import '../../core/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

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

    // Sync Settings to Timer
    timerService.updateSettings(
      settings.pomodoroMinutes, 
      settings.shortBreakMinutes, 
      settings.longBreakMinutes
    );

    timerService.onPomodoroComplete = (taskId) {
      taskProvider.incrementPomodoro(taskId);
      
      // Check if task is completed
      try {
        final task = taskProvider.tasks.firstWhere((t) => t.id == taskId);
        
        // LOG HISTORY
        historyProvider.logSession(settings.pomodoroMinutes, task.title);

        if (task.isCompleted) {
          timerService.setActiveTask(null, null); // Clear active task from timer
        }
      } catch (e) {
        // Task might have been deleted
      }
    };

    return BackgroundAnimator(
      child: Scaffold(
        resizeToAvoidBottomInset: false, // Prevent keyboard from pushing up background
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Base Gradient (Bottom Layer)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.background.withOpacity(0.9),
                    Theme.of(context).primaryColor.withOpacity(0.1),
                  ],
                ),
              ),
            ),
            
            // Current Screen Content
            // We use IndexedStack to preserve state or just switch? 
            // Switching is better for "Settings" to refresh language immediately.
            SafeArea(
              bottom: false, // We handle bottom padding for nav bar manually or via padding
              child: _screens[_currentIndex],
            ),

            // Custom Floating Bottom Navigation
            Positioned(
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).padding.bottom + 10, // Dynamic bottom padding
                child: GlassBox(
                blur: 20,
                opacity: 0.15,
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Reduced vertical padding
                borderRadius: BorderRadius.circular(35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(0, CupertinoIcons.timer, "Focus"),
                    _buildNavItem(1, CupertinoIcons.check_mark_circled, "Tasks"),
                    _buildNavItem(2, CupertinoIcons.graph_square, "Stats"),
                    _buildNavItem(3, CupertinoIcons.settings, "Settings"),
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
        : Theme.of(context).iconTheme.color?.withOpacity(0.5) ?? Colors.grey;

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
                    BoxShadow(color: color.withOpacity(0.5), blurRadius: 5, spreadRadius: 1)
                  ]
                ),
              ),
          ],
        ),
      ),
    );
  }
}
