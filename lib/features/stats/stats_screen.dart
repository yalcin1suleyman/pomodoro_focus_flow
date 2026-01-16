import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../core/widgets/glass_box.dart';
import '../../core/theme/app_theme.dart';
import '../settings/settings_provider.dart';
import 'history_provider.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  DateTime _focusedMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final historyProvider = Provider.of<HistoryProvider>(context);

    // Get Today's Stats
    final today = DateTime.now();
    final todayRecord = historyProvider.getRecord(today);
    
    // Calculate Progress
    final int focusedMinutes = todayRecord.minutesFocused;
    final double progressPercent = settings.dailyGoalMinutes > 0 
        ? (focusedMinutes / settings.dailyGoalMinutes).clamp(0.0, 1.0)
        : 0.0;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                settings.translate('stats'),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Calendar Card
              GlassBox(
                child: Column(
                  children: [
                    // Month Header with Navigation
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left),
                            onPressed: () {
                              setState(() {
                                _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
                              });
                            },
                          ),
                          Text(
                            _formatMonth(_focusedMonth, settings), 
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)
                          ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            onPressed: () {
                              setState(() {
                                _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Days Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: ["M", "T", "W", "T", "F", "S", "S"]
                          .map((e) => Text(e, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)))
                          .toList(),
                    ),
                    const SizedBox(height: 10),
                            // Calendar Grid
                    _buildCalendarGrid(context, historyProvider),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLegendItem(Theme.of(context).colorScheme.secondary, settings.translate('completed')), // Activity present
                        const SizedBox(width: 15),
                        _buildLegendItem(Colors.grey.withOpacity(0.3), settings.translate('empty')), 
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Today's Goal Card (Interactive)
              GestureDetector(
                onTap: () => _showGoalDialog(context, settings),
                child: GlassBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(settings.translate('today'), style: Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.background.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min, 
                                  children: [
                                    Flexible( 
                                      child: Text(
                                        "${settings.translate('dailyGoal')} ${(settings.dailyGoalMinutes / 60).toStringAsFixed(1)}h", 
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Icon(Icons.edit, size: 14, color: Colors.grey),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text("${(focusedMinutes / 60).toStringAsFixed(1)}h", 
                                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold)),

                              Text(settings.translate('inProgress'), style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                        CircularPercentIndicator(
                          radius: 60.0,
                          lineWidth: 12.0,
                          percent: progressPercent,
                          center: Icon(Icons.check, size: 40, color: _getProgressColor(context, progressPercent)),
                          progressColor: _getProgressColor(context, progressPercent),
                          backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 140),
            ],
          ),
        ),
      ),
    );
  }

  Color _getProgressColor(BuildContext context, double ratio) {
    if (ratio >= 1.0) {
      // Reached & Exceeded: Green Tones (Light Green to Deep Green)
      // Cap intensity at 2.0 (double goal) for maximum darkness
      double intensity = (ratio - 1.0).clamp(0.0, 1.0); 
      return Color.lerp(Colors.green.shade500, Colors.green.shade900, intensity)!;
    } else if (ratio >= 0.5) {
      // Close (50% - 99%): Yellow/Amber Tones
      // Using Amber because Yellow is often too light to see clearly
      double intensity = (ratio - 0.5) / 0.5;
      return Color.lerp(Colors.amber.shade300, Colors.amber.shade900, intensity)!; 
    } else {
      // Far (0% - 49%): Red Tones
      double intensity = ratio / 0.5;
      return Color.lerp(Colors.red.shade300, Colors.red.shade900, intensity.clamp(0.2, 1.0))!;
    }
  }

  Widget _buildCalendarGrid(BuildContext context, HistoryProvider history) {
    // Generate days for focused month
    final daysInMonth = DateUtils.getDaysInMonth(_focusedMonth.year, _focusedMonth.month);
    final firstDayOfMonth = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final firstWeekday = firstDayOfMonth.weekday; // 1 = Mon, 7 = Sun
    
    // Offset for grid (Monday start)
    final offset = firstWeekday - 1;
    final theme = Theme.of(context);
    final settings = Provider.of<SettingsProvider>(context, listen: false);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: daysInMonth + offset, 
      itemBuilder: (context, index) {
         if (index < offset) return const SizedBox(); 
         
         final day = index - offset + 1;
         final date = DateTime(_focusedMonth.year, _focusedMonth.month, day);
         
         final record = history.getRecord(date);
         final bool hasActivity = record.minutesFocused > 0;
         final bool isToday = DateUtils.isSameDay(date, DateTime.now());

         // Calculate Status Color
         final double ratio = settings.dailyGoalMinutes > 0 
            ? (record.minutesFocused / settings.dailyGoalMinutes) 
            : 0;
         final Color statusColor = _getProgressColor(context, ratio);

         Color? borderColor;
         Color? fillColor;
         Color? textColor;
         
         if (isToday) {
            borderColor = statusColor;
            fillColor = hasActivity ? statusColor : null;
            textColor = hasActivity ? Colors.white : statusColor; 
         } else if (hasActivity) {
            borderColor = statusColor;
            fillColor = statusColor.withOpacity(0.2);
            textColor = statusColor; // Keep text same as status
         } else {
            borderColor = Colors.transparent;
            textColor = Colors.grey;
         }

         return GestureDetector(
           onTap: () => _showDailyDetails(context, date, record, history),
           child: Container(
             alignment: Alignment.center,
             decoration: BoxDecoration(
               color: fillColor,
               shape: BoxShape.circle,
               border: Border.all(color: borderColor ?? Colors.transparent, width: 2),
             ),
             child: Text("$day", style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
           ),
         );
      },
    );
  }

  void _showDailyDetails(BuildContext context, DateTime date, DailyRecord record, HistoryProvider history) {
    TextEditingController noteController = TextEditingController(text: record.note);
    bool isEditing = false;
    final settings = Provider.of<SettingsProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          titlePadding: const EdgeInsets.fromLTRB(24, 20, 10, 0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_formatDate(date, settings)),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(ctx),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(settings.translate('focusedTime'), style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        Text("${record.minutesFocused} ${settings.translate('minutes')}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                
                Text(settings.translate('tasksWorkedOn'), style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                if (record.tasksWorkedOn.isEmpty)
                  Text(settings.translate('noTasksRecorded'), style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey))
                else
                  Wrap(
                    spacing: 8,
                    children: record.tasksWorkedOn.map((t) => Chip(label: Text(t))).toList(),
                  ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(settings.translate('dailyNote'), style: const TextStyle(fontWeight: FontWeight.bold)),
                    if (!isEditing)
                       IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        tooltip: settings.translate('editNote'),
                        onPressed: () => setState(() => isEditing = true),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                
                if (isEditing)
                  TextField(
                    controller: noteController,
                    maxLines: 3,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: settings.translate('noteHint'),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.background.withOpacity(0.5),
                    ),
                  )
                else
                   Container(
                     width: double.infinity,
                     padding: const EdgeInsets.all(12),
                     decoration: BoxDecoration(
                       color: Theme.of(context).colorScheme.background.withOpacity(0.3),
                       borderRadius: BorderRadius.circular(10),
                       border: Border.all(color: Colors.white.withOpacity(0.1))
                     ),
                     child: Text(
                       (record.note?.isEmpty ?? true) ? settings.translate('noteHint') : record.note!,
                       style: TextStyle(
                         color: (record.note?.isEmpty ?? true) ? Colors.grey : Theme.of(context).textTheme.bodyMedium?.color,
                         fontStyle: (record.note?.isEmpty ?? true) ? FontStyle.italic : FontStyle.normal
                       ),
                     ),
                   ),
              ],
            ),
          ),
          actions: [
            if (isEditing) ...[
              TextButton(
                onPressed: () => setState(() => isEditing = false),
                child: Text(settings.translate('cancel')),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
                onPressed: () {
                  history.updateNote(date, noteController.text);
                  setState(() => isEditing = false); 
                },
                child: Text(settings.translate('save'), style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
              )
            ]
          ],
        ),
      ),
    );
  }

  void _showGoalDialog(BuildContext context, SettingsProvider settings) {
    double currentVal = settings.dailyGoalMinutes.toDouble();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        title: Text(settings.translate('setGoal')),
        content: SizedBox(
          height: 100,
          child: Column(
            children: [
              Text("${(currentVal/60).toStringAsFixed(1)} ${settings.translate('hours')}"),
              StatefulBuilder(
                builder: (context, setState) {
                  return Slider(
                    value: currentVal,
                    min: 30, // 30 min
                    max: 720, // 12 hours
                    divisions: 23,
                    label: "${(currentVal/60).toStringAsFixed(1)} h",
                    activeColor: Theme.of(context).colorScheme.primary,
                    onChanged: (val) {
                      setState(() => currentVal = val);
                    },
                  );
                }
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(settings.translate('cancel')),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
            onPressed: () {
              settings.setDailyGoal(currentVal.toInt());
              Navigator.pop(ctx);
            },
            child: Text(settings.translate('save'), style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
          )
        ],
      )
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  }

  String _formatMonth(DateTime date, SettingsProvider settings) {
    final months = [
      settings.translate('monthJan'), settings.translate('monthFeb'), 
      settings.translate('monthMar'), settings.translate('monthApr'),
      settings.translate('monthMay'), settings.translate('monthJun'), 
      settings.translate('monthJul'), settings.translate('monthAug'),
      settings.translate('monthSep'), settings.translate('monthOct'), 
      settings.translate('monthNov'), settings.translate('monthDec')
    ];
    return "${months[date.month - 1]} ${date.year}";
  }

  String _formatDate(DateTime date, SettingsProvider settings) {
    return "${date.day} ${_formatMonth(date, settings)}";
  }
