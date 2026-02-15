import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/rendering.dart' as rendering;
import 'dart:ui' as ui;
import 'dart:io';
import '../../core/widgets/glass_box.dart';
import '../settings/settings_provider.dart';
import 'history_provider.dart';
import 'widgets/story_stats_card.dart';
import '../../core/services/ad_service.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  DateTime _focusedMonth = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  
  // Rotating motivational quotes


  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final historyProvider = Provider.of<HistoryProvider>(context);

    // Get Selected Day Stats
    // Get Selected Day Stats
    final selectedRecord = historyProvider.getRecord(_selectedDate);
    final bool isSelectedToday = DateUtils.isSameDay(_selectedDate, DateTime.now());
    
    // Calculate Progress for Selected Day
    final int focusedMinutes = selectedRecord.minutesFocused;
    final int targetGoal = selectedRecord.targetMinutes ?? settings.dailyGoalMinutes;

    final double progressPercent = targetGoal > 0 
        ? (focusedMinutes / targetGoal).clamp(0.0, 1.0)
        : 0.0;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    settings.translate('stats'),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _handleShareAction(context, settings, selectedRecord, focusedMinutes),
                    icon: Icon(Icons.share, color: Theme.of(context).colorScheme.primary),
                  ),
                ],
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
                        // Goal Met (Solid)
                        _buildLegendItem(Theme.of(context).colorScheme.primary, settings.translate('goalMet')), 
                        const SizedBox(width: 15),
                        // Goal Missed (Hollow/Ring)
                        Row(
                          children: [
                            Container(
                              width: 8, 
                              height: 8, 
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // Bright border (No opacity)
                                border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2.5)
                              )
                            ),
                            const SizedBox(width: 5),
                            Text(settings.translate('goalMissed'), style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(width: 15),
                        // Empty
                        _buildLegendItem(Colors.grey.withValues(alpha: 0.3), settings.translate('empty')), 
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Selected Day Goal/Stats Card
              GlassBox(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Header: Date and Edit Note Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _formatDate(_selectedDate, settings),
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              Text(
                                isSelectedToday 
                                  ? settings.translate('dailyGoal') 
                                  : settings.translate('completed'),
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          ),
// IconButton removed per request
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Main Content: Timer & Progress
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Focus Time Display
                                      FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        (focusedMinutes / 60).toStringAsFixed(1),
                                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        "h",
                                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                          color: Theme.of(context).colorScheme.primary,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        "/ ${(targetGoal / 60).toStringAsFixed(1)} h",
                                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          CircularPercentIndicator(
                            radius: 60.0,
                            lineWidth: 12.0,
                            percent: progressPercent,
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${(progressPercent * 100).toInt()}%",
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                                ),
                              ],
                            ),
                            progressColor: Theme.of(context).colorScheme.primary,
                            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                            circularStrokeCap: CircularStrokeCap.round,
                            animation: true,
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),

                      // Note Section with improved visual
                      if (selectedRecord.note != null && selectedRecord.note!.isNotEmpty)
                        GestureDetector(
                          onTap: () => _showNoteDialog(context, settings, selectedRecord),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
                              )
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.format_quote_rounded, size: 20, color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.7)),
                                    const SizedBox(width: 8),
                                    Text(
                                      settings.translate('dailyNote'), 
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  selectedRecord.note!,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontStyle: FontStyle.italic,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        GestureDetector(
                           onTap: () => _showNoteDialog(context, settings, selectedRecord),
                           child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                settings.translate('addNote'),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                           ),
                        ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Tasks List for Selected Day
              GlassBox(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        settings.translate('tasksWorkedOn'),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      if (selectedRecord.tasksWorkedOn.isEmpty)
                        Text(
                          settings.translate('noTasksRecorded'),
                          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                        )
                      else
                        ...selectedRecord.tasksWorkedOn.map((task) {
                          // Check if this task is completed
                          final isCompleted = selectedRecord.completedTasks.contains(task);
                          
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                Icon(
                                  isCompleted ? Icons.check_circle : Icons.check_circle_outline,
                                  size: 16,
                                  color: isCompleted 
                                    ? Theme.of(context).colorScheme.primary 
                                    : Theme.of(context).colorScheme.secondary,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    task,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: isCompleted ? FontWeight.w600 : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                    ],
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



  Widget _buildCalendarGrid(BuildContext context, HistoryProvider history) {
    // Generate days for focused month
    final daysInMonth = DateUtils.getDaysInMonth(_focusedMonth.year, _focusedMonth.month);
    final firstDayOfMonth = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final firstWeekday = firstDayOfMonth.weekday; // 1 = Mon, 7 = Sun
    
    // Offset for grid (Monday start)
    final offset = firstWeekday - 1;
    // offset logic
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    // unused locals removed
    

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
         
         // Selection Logic
         bool isSelected = false;
         isSelected = DateUtils.isSameDay(date, _selectedDate);
         bool isResultOfSelection = isSelected;
         
         // Future Check
         final now = DateTime.now();
         final bool isFuture = date.isAfter(DateTime(now.year, now.month, now.day));

          final Color themeColor = Theme.of(context).colorScheme.primary; 

          // VISUALIZATION LOGIC
          double circleSize = 30.0;
          double fontSize = 12.0;

          // 1. Goal Determination
          bool isGoalMet = false;
          
          final int recordGoal = record.targetMinutes ?? settings.dailyGoalMinutes;
          isGoalMet = record.minutesFocused >= recordGoal;

          // 2. Size = EFFORT (Volume)
          if (hasActivity) {
             const double maxVolumeMinutes = 480.0; // 8 hours = max size
             double volumeRatio = (record.minutesFocused / maxVolumeMinutes).clamp(0.0, 1.0);
             
             // Min size 28 (visible), Max size 52 (large)
             const double minSize = 28.0;
             const double maxSize = 52.0;
             
             circleSize = minSize + (volumeRatio * (maxSize - minSize));
             fontSize = 11.0 + (volumeRatio * 4.0);
          } else if (isResultOfSelection) {
             circleSize = 40.0; // Empty selected
          } else {
             circleSize = 34.0; // Empty standard
          }

          // 3. Color/Style
          // If goal met: Solid Color
          // If goal missed: COMPLETELY Transparent (Hollow)
 
          
          return GestureDetector(
            onTap: isFuture ? null : () { 
               setState(() {
                 _selectedDate = date;
               });
            },
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: circleSize,
                height: circleSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: hasActivity 
                      ? (isGoalMet ? themeColor : Colors.transparent) 
                      : Colors.transparent, 
                  
                  shape: BoxShape.circle,
                  
                  border: isSelected 
                      ? Border.all(color: themeColor, width: 2) // Selection ring
                      : (hasActivity && !isGoalMet 
                          ? Border.all(color: themeColor, width: 2.5) // Missed goal (Bright/No Opacity)
                          : (hasActivity ? null : Border.all(color: Colors.transparent))),
                ),
                child: Text(
                  "$day", 
                  style: TextStyle(
                    color: hasActivity 
                        ? (isGoalMet ? Colors.white : themeColor) 
                        : (isSelected ? themeColor : Colors.grey), 
                    fontWeight: FontWeight.bold,
                    fontSize: hasActivity ? fontSize : 14,
                  )
                ),
              ),
            ),
          );
      },
    );
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



  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }



  void _showShareDialog(BuildContext context, SettingsProvider settings, DailyRecord record, int focusedMinutes) {
    final GlobalKey boundaryKey = GlobalKey();
    final history = Provider.of<HistoryProvider>(context, listen: false);
    
    // Initial State
    String selectedRange = 'daily'; 
    
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) {



          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(10),
            child: SingleChildScrollView( 
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Controls Row
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Range Selector
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white10),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedRange,
                                dropdownColor: Theme.of(context).cardColor,
                                style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color, fontWeight: FontWeight.bold, fontSize: 13),
                                onChanged: (val) {
                                  if (val != null) setState(() => selectedRange = val);
                                },
                                items: [
                                  DropdownMenuItem(value: 'daily', child: Text(settings.translate('shareRangeDaily'))),
                                  DropdownMenuItem(value: 'weekly', child: Text(settings.translate('shareRangeWeekly'))),
                                  DropdownMenuItem(value: 'monthly', child: Text(settings.translate('shareRangeMonthly'))),
                                  DropdownMenuItem(value: 'yearly', child: Text(settings.translate('shareRangeYearly'))),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),


                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      RepaintBoundary(
                        key: boundaryKey,
                        child: StoryStatsCard(
                              mode: _getStoryMode(selectedRange),
                              date: _getShareDate(selectedRange),
                              settings: settings,
                              historyProvider: history,
                              dailyRecord: record,
                            ),
                      ),
                       IconButton(
                         icon: const Icon(Icons.close, color: Colors.white),
                         onPressed: () => Navigator.of(ctx).pop(),
                       ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        final boundary = boundaryKey.currentContext?.findRenderObject() as rendering.RenderRepaintBoundary?;
                        if (boundary == null) return;

                        final image = await boundary.toImage(pixelRatio: 3.0);
                        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
                        final pngBytes = byteData?.buffer.asUint8List();

                        if (pngBytes != null) {
                          final directory = await getTemporaryDirectory();
                          final path = '${directory.path}/focus_story_share.png';
                          final file = File(path);
                          await file.writeAsBytes(pngBytes);

                          final xFile = XFile(path);
                          if (context.mounted) {
                            Navigator.pop(ctx); 
                            await Share.shareXFiles([xFile], text: settings.translate('shareMessage'));
                          }
                        }
                      } catch (e) {
                        debugPrint("Error sharing: $e");
                      }
                    },
                    icon: const Icon(Icons.share),
                    label: Text(settings.translate('share')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  void _showNoteDialog(BuildContext context, SettingsProvider settings, DailyRecord record) {
    final TextEditingController noteController = TextEditingController(text: record.note);
    final history = Provider.of<HistoryProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.edit_note, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 10),
            Text(settings.translate('editNote')), 
          ],
        ),
        content: TextField(
          controller: noteController,
          maxLines: 5,
          minLines: 3,
          decoration: InputDecoration(
            hintText: settings.translate('noteHint'),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(settings.translate('cancel'), style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              history.updateNote(_selectedDate, noteController.text);
              Navigator.pop(ctx);
            },
            child: Text(settings.translate('save')),
          )
        ],
      )
    );
  }
  StoryMode _getStoryMode(String range) {
    switch (range) {
      case 'daily': return StoryMode.daily;
      case 'weekly': return StoryMode.weekly;
      case 'monthly': return StoryMode.monthly;
      case 'yearly': return StoryMode.yearly;
      default: return StoryMode.daily;
    }
  }

  DateTime _getShareDate(String range) {
    if (range == 'monthly' || range == 'yearly') {
       return _focusedMonth; 
    }
    return _selectedDate;
  }

  void _handleShareAction(BuildContext context, SettingsProvider settings, DailyRecord record, int focusedMinutes) {
    final String content = settings.translate('shareAdUnlockContent');
    final String buttonText = settings.translate('shareAdUnlockButton');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.lock_outline, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 10),
            Text(settings.translate('share')), 
          ],
        ),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(settings.translate('cancel'), style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              AdService().showRewardedAd(
                onRewardEarned: () {
                   _showShareDialog(context, settings, record, focusedMinutes);
                },
                onAdDismissed: () {
                  // Optional: Show message if dismissed without reward
                }
              );
            },
            child: Text(buttonText),
          )
        ],
      )
    );
  }
}
