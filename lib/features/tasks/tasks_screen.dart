import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';
import 'task_model.dart'; // Ensure Task model is imported if needed, usually exported by provider or same file structure
import '../timer/timer_service.dart';
import '../settings/settings_provider.dart';
import '../../core/widgets/glass_box.dart';

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

  void _showHelpSheet(BuildContext context, SettingsProvider settings) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (_, controller) => GlassBox(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: Column(
            children: [
              // Handle Bar
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Icon(Icons.help_outline, color: Theme.of(context).colorScheme.primary, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        settings.translate('tasksHelpTitle'),
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Content
              Expanded(
                child: ListView(
                  controller: controller,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  children: [
                    _buildHelpStep(context, "1", settings.translate('tasksHelpStep1Title'), settings.translate('tasksHelpStep1Content')),
                    _buildHelpStep(context, "2", settings.translate('tasksHelpStep2Title'), settings.translate('tasksHelpStep2Content')),
                    _buildHelpStep(context, "3", settings.translate('tasksHelpStep3Title'), settings.translate('tasksHelpStep3Content')),
                    _buildHelpStep(context, "4", settings.translate('tasksHelpStep4Title'), settings.translate('tasksHelpStep4Content')),
                    _buildHelpStep(context, "5", settings.translate('tasksHelpStep5Title'), settings.translate('tasksHelpStep5Content')),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHelpStep(BuildContext context, String number, String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Text(
              number,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showTaskDialog(BuildContext context, SettingsProvider settings, {Task? task}) {
    final titleController = TextEditingController(text: task?.title ?? "");
    int estimated = task?.estimatedPomodoros ?? 1;
    final theme = Theme.of(context);
    final isEditing = task != null;

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
            color: theme.scaffoldBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEditing ? settings.translate('updateTask') : settings.translate('newTask'), 
                    style: theme.textTheme.headlineSmall
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: titleController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: settings.translate('taskHint'),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(settings.translate('estPomodoros'), style: theme.textTheme.bodyLarge),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (estimated > 1) setState(() => estimated--);
                            },
                            icon: const Icon(Icons.remove_circle_outline),
                            color: theme.colorScheme.primary,
                          ),
                          Text("$estimated", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          IconButton(
                            onPressed: () => setState(() => estimated++),
                            icon: const Icon(Icons.add_circle_outline),
                            color: theme.colorScheme.primary,
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
                          final provider = Provider.of<TaskProvider>(context, listen: false);
                          if (isEditing) {
                            provider.updateTask(task.id, titleController.text, estimated);
                          } else {
                            provider.addTask(titleController.text, estimated);
                          }
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Text(isEditing ? settings.translate('save') : settings.translate('createTask')),
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100.0), // Normal padding
        child: FloatingActionButton(
          onPressed: () => _showTaskDialog(context, settings),
          backgroundColor: theme.colorScheme.secondary,
          child: Icon(Icons.add, color: theme.colorScheme.onSecondary),
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
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => _showHelpSheet(context, settings),
                      icon: Icon(Icons.help_outline, color: theme.colorScheme.primary),
                      tooltip: settings.translate('tasksHelpTitle'),
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
                            settings.translate('noTasks'),
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 110), // Normal list padding
                          itemCount: provider.tasks.length,
                          itemBuilder: (context, index) {
                            final task = provider.tasks[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Slidable(
                                key: Key(task.id),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) => _showTaskDialog(context, settings, task: task),
                                      backgroundColor: theme.colorScheme.secondary,
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit,
                                      label: settings.translate('editNote'), // Using 'editNote' as 'Edit'
                                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
                                    ),
                                    SlidableAction(
                                      onPressed: (context) => provider.deleteTask(task.id),
                                      backgroundColor: theme.colorScheme.error,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: settings.translate('delete'),
                                      borderRadius: const BorderRadius.horizontal(right: Radius.circular(20)),
                                    ),
                                  ],
                                ),
                                child: GlassBox(
                                  opacity: task.isCompleted ? 0.05 : 0.1,
                                  child: ListTile(
                                    // Make checkbox READ-ONLY (removed GestureDetector)
                                    leading: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: task.isCompleted ? theme.colorScheme.primary : Colors.grey,
                                            width: 2,
                                          ),
                                          color: task.isCompleted ? theme.colorScheme.primary : null,
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
                                    subtitle: Row(
                                      children: [
                                        Icon(Icons.flag, size: 14, color: theme.colorScheme.primary),
                                        const SizedBox(width: 4),
                                        Text(
                                          "${task.estimatedPomodoros}",
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(width: 8),
                                        const Text("/"),
                                        const SizedBox(width: 8),
                                        Icon(Icons.check_circle, size: 14, color: theme.colorScheme.primary),
                                        const SizedBox(width: 4),
                                        Text(
                                          "${task.completedPomodoros}",
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.play_circle_fill),
                                      color: task.isCompleted ? Colors.grey : theme.colorScheme.primary,
                                      onPressed: task.isCompleted ? null : () {
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
