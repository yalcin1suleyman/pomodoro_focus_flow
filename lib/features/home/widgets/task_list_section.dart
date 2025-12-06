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
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık + Add butonu
          Row(
            children: [
              const Text(
                "Tasks",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: onAddTask,
                icon: const Icon(Icons.add, size: 18),
                label: const Text("Add"),
                style: TextButton.styleFrom(
                  minimumSize: const Size(0, 0),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          if (tasks.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "No tasks yet. Add your first focus target.",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
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
    final textStyle = TextStyle(
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
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white60,
              ),
            ),
        ],
      ),
    );
  }
}
