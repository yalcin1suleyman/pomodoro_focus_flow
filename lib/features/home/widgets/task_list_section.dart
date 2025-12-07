
import 'package:flutter/material.dart';
import '../../../models/task_models.dart';

class TaskListSection extends StatelessWidget {
  final List<FocusTask> tasks;
  final VoidCallback onAddTask;
  final void Function(String taskId)? onToggleDone;

  final Color accentColor;
  final Color cardColor;

  const TaskListSection({
    super.key,
    required this.tasks,
    required this.onAddTask,
    this.onToggleDone,
    required this.accentColor,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ───────── Başlık + Add butonu ─────────
          Row(
            children: [
              Text(
                "TASKS",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                  color: Colors.white.withOpacity(0.94),
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: onAddTask,
                icon: Icon(Icons.add, size: 18, color: accentColor),
                label: Text(
                  "Add",
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6,
                    color: accentColor,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  minimumSize: const Size(0, 0),
                  foregroundColor: accentColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // ───────── İçerik ─────────
          if (tasks.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "No tasks yet. Add your first focus target.",
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.65),
                  height: 1.4,
                ),
              ),
            )
          else
            Column(
              children: [
                for (final t in tasks)
                  _TaskItem(
                    task: t,
                    accentColor: accentColor,
                    onToggle: onToggleDone == null
                        ? null
                        : () => onToggleDone!(t.id),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  final FocusTask task;
  final VoidCallback? onToggle;
  final Color accentColor;

  const _TaskItem({
    required this.task,
    this.onToggle,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textStyle = theme.textTheme.bodyMedium?.copyWith(
      fontSize: 13,
      color: task.isDone ? Colors.white54 : Colors.white,
      decoration:
      task.isDone ? TextDecoration.lineThrough : TextDecoration.none,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: task.isDone ? accentColor : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: task.isDone ? accentColor : Colors.white38,
                  width: 1.4,
                ),
              ),
              child: task.isDone
                  ? const Icon(Icons.check, size: 16, color: Colors.black)
                  : null,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              task.title,
              style: textStyle,
            ),
          ),
          if (task.targetPomodoros != null)
            Text(
              "${task.completedPomodoros}/${task.targetPomodoros}",
              style: theme.textTheme.labelSmall?.copyWith(
                fontSize: 11,
                color: Colors.white60,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}
