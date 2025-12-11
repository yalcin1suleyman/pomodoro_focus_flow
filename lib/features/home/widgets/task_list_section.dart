import 'package:flutter/material.dart';
import '../../../models/task_models.dart';
import '../../../core/localization/app_language.dart';

class TaskListSection extends StatelessWidget {
  final AppLanguage language;
  final List<FocusTask> tasks;
  final VoidCallback onAddTask;
  final void Function(String taskId)? onToggleDone;

  /// Görev düzenleme callback’i
  final void Function(FocusTask task)? onEditTask;

  /// Göreve tıklayınca pomodoro başlatmak için callback
  final void Function(FocusTask task)? onTapTask;

  final Color accentColor;
  final Color cardColor;

  const TaskListSection({
    super.key,
    required this.language,
    required this.tasks,
    required this.onAddTask,
    this.onToggleDone,
    this.onEditTask,
    required this.accentColor,
    required this.cardColor,
    this.onTapTask,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ───────────────────── HEADER
          Row(
            children: [
              Text(
                tt(language, "Görevler", "Tasks"),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 14,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: onAddTask,
                icon: const Icon(Icons.add, size: 18),
                label: Text(tt(language, "Ekle", "Add")),
                style: TextButton.styleFrom(
                  foregroundColor: accentColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                    side: BorderSide(
                      color: accentColor.withOpacity(0.6),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          const Divider(height: 1, color: Colors.white12),
          const SizedBox(height: 10),

          // ───────────────────── GÖREVLER
          _buildTaskList(theme),
        ],
      ),
    );
  }

  // LIST BUILDER ― Expanded kullanılmayacak
  Widget _buildTaskList(ThemeData theme) {
    // Görev yoksa basit mesaj
    if (tasks.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          tt(
            language,
            "Henüz görev yok. İlk odak hedefini ekle.",
            "No tasks yet. Add your first focus target.",
          ),
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      );
    }

    // Görev varsa kaydırılabilir bir alan oluştur
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 250, // tüm cihazlarda güvenli — overflow olmaz
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return _TaskItem(
            task: task,
            accentColor: accentColor,
            onToggle: onToggleDone == null
                ? null
                : () => onToggleDone!(task.id),
            onEdit: onEditTask == null
                ? null
                : () => onEditTask!(task),
            onTap: onTapTask == null
                ? null
                : () => onTapTask!(task),
          );
        },
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  final FocusTask task;
  final VoidCallback? onToggle;
  final VoidCallback? onEdit;

  /// Satıra tıklayınca çalışacak callback (pomodoro başlatma için)
  final VoidCallback? onTap;

  final Color accentColor;

  const _TaskItem({
    required this.task,
    this.onToggle,
    this.onEdit,
    this.onTap,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            // Checkbox
            GestureDetector(
              onTap: onToggle,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: task.isDone ? accentColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: task.isDone ? accentColor : Colors.white38,
                    width: 1.5,
                  ),
                ),
                child: task.isDone
                    ? const Icon(Icons.check, size: 15, color: Colors.black)
                    : null,
              ),
            ),
            const SizedBox(width: 10),

            // Başlık
            Expanded(
              child: Text(
                task.title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                  color: task.isDone ? Colors.white54 : Colors.white,
                  decoration: task.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),

            // Hedef pomodoro sayısı
            if (task.targetPomodoros != null)
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  "${task.completedPomodoros}/${task.targetPomodoros}",
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white70,
                  ),
                ),
              ),

            // Düzenle ikonu
            if (onEdit != null) ...[
              const SizedBox(width: 6),
              IconButton(
                onPressed: onEdit,
                icon: const Icon(
                  Icons.edit_outlined,
                  size: 18,
                  color: Colors.white54,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
