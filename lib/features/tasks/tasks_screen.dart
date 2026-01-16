import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';
import 'task_model.dart';
import '../timer/timer_service.dart';
import '../settings/settings_provider.dart';
import '../../core/widgets/glass_box.dart';
import '../../core/theme/app_theme.dart';

class TasksScreen extends StatefulWidget {
  final VoidCallback? onNavigationRequest;
  const TasksScreen({super.key, this.onNavigationRequest});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  // Confetti removed as per request

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showAddTaskDialog(BuildContext context, SettingsProvider settings) {
    final titleController = TextEditingController();
    int estimated = 1;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: GlassBox(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            opacity: 0.9,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(settings.language == 'tr' ? "Yeni Görev" : "New Task", style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 20),
                  TextField(
                    controller: titleController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: settings.language == 'tr' ? "Ne üzerinde çalışıyorsun?" : "What are you working on?",
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(settings.language == 'tr' ? "Tahmini Pomodoro:" : "Est. Pomodoros:", style: Theme.of(context).textTheme.bodyLarge),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (estimated > 1) setState(() => estimated--);
                            },
                            icon: const Icon(Icons.remove_circle_outline),
                            color: AppColors.accent,
                          ),
                          Text("$estimated", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          IconButton(
                            onPressed: () => setState(() => estimated++),
                            icon: const Icon(Icons.add_circle_outline),
                            color: AppColors.accent,
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (titleController.text.isNotEmpty) {
                          // Access the GLOBAL provider, not a local one
                          Provider.of<TaskProvider>(context, listen: false)
                              .addTask(titleController.text, estimated);
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryLight,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Text(settings.language == 'tr' ? "Görev Oluştur" : "Create Task"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Access global providers
    final provider = Provider.of<TaskProvider>(context);
    final settings = Provider.of<SettingsProvider>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0), // Raise FAB
        child: FloatingActionButton(
          onPressed: () => _showAddTaskDialog(context, settings),
          backgroundColor: AppColors.accent,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Text(
                    settings.translate('tasks'),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : provider.tasks.isEmpty
                      ? Center(
                          child: Text(
                            settings.language == 'tr' ? "Henüz görev yok. Bir tane ekle!" : "No tasks yet. Start by adding one!",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
                          itemCount: provider.tasks.length,
                          itemBuilder: (context, index) {
                            final task = provider.tasks[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Dismissible(
                                key: Key(task.id),
                                onDismissed: (_) => provider.deleteTask(task.id),
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(Icons.delete, color: Colors.red),
                                ),
                                child: GlassBox(
                                  opacity: task.isCompleted ? 0.05 : 0.1,
                                  child: ListTile(
                                    // Make checkbox READ-ONLY (removed GestureDetector)
                                    leading: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: task.isCompleted ? AppColors.accent : Colors.grey,
                                            width: 2,
                                          ),
                                          color: task.isCompleted ? AppColors.accent : null,
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: task.isCompleted 
                                          ? const Icon(Icons.check, size: 16, color: Colors.white)
                                          : const SizedBox(width: 16, height: 16),
                                      ),
                                    title: Text(
                                      task.title,
                                      style: TextStyle(
                                        decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                                        color: task.isCompleted ? Colors.grey : null,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "${task.completedPomodoros} / ${task.estimatedPomodoros} pomodoros",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.play_circle_fill),
                                      color: AppColors.primaryLight.withOpacity(0.8),
                                      onPressed: () {
                                        // Set Active Task and RESET Timer
                                        Provider.of<TimerService>(context, listen: false)
                                            .startSessionForTask(task.id, task.title);
                                        // Invoke callback to switch to Timer screen
                                        widget.onNavigationRequest?.call();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
