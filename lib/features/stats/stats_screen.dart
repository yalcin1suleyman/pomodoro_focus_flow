import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/rendering.dart' as rendering;
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/services.dart';
import '../../core/widgets/glass_box.dart';
import '../../core/theme/app_theme.dart';
import '../settings/settings_provider.dart';
import 'history_provider.dart';
import 'widgets/share_stats_card.dart';

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
    final selectedRecord = historyProvider.getRecord(_selectedDate);
    final bool isSelectedToday = DateUtils.isSameDay(_selectedDate, DateTime.now());
    
    // Calculate Progress for Selected Day
    final int focusedMinutes = selectedRecord.minutesFocused;
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
                    onPressed: () => _showShareDialog(context, settings, selectedRecord, focusedMinutes),
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
                        _buildLegendItem(Theme.of(context).colorScheme.primary, settings.translate('completed')), // Activity present
                        const SizedBox(width: 15),
                        _buildLegendItem(Colors.grey.withOpacity(0.3), settings.translate('empty')), 
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Selected Day Goal/Stats Card
              GestureDetector(
                onTap: isSelectedToday ? () => _showGoalDialog(context, settings) : null,
                child: GlassBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title Date
                              Text(
                                _formatDate(_selectedDate, settings), 
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              
                              // Main Focus Time Display
                              // Main Focus Time Display - Inline as requested
                              FittedBox( // Scale down if too wide
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${(focusedMinutes / 60).toStringAsFixed(1)}h", 
                                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "/ ${(settings.dailyGoalMinutes / 60).toStringAsFixed(1)}h",
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        color: Colors.grey.withOpacity(0.8),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    if (isSelectedToday)
                                      Padding( // Use Padding+InkWell for tighter control than IconButton
                                        padding: const EdgeInsets.only(left: 8, bottom: 6),
                                        child: InkWell(
                                          onTap: () => _showGoalDialog(context, settings),
                                          borderRadius: BorderRadius.circular(12),
                                          child: Icon(
                                            Icons.edit, 
                                            size: 20, 
                                            color: Theme.of(context).colorScheme.primary.withOpacity(0.8)
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),

                              // Status Label
                              Text(
                                isSelectedToday ? settings.translate('dailyGoal') : settings.translate('completed'), 
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              
                              // Notes or Quote
                              const SizedBox(height: 16),
                              if (selectedRecord.note != null && selectedRecord.note!.isNotEmpty)
                                Text(
                                  "\"${selectedRecord.note}\"",
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 15,
                                  ),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                )
                              else
                                const SizedBox(height: 0), // No quote here anymore
                            ],
                          ),
                        ),
                        // Right Side Diagram
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             CircularPercentIndicator(
                              radius: 55.0,
                              lineWidth: 10.0,
                              percent: progressPercent,
                              center: Text(
                                "${(progressPercent * 100).toInt()}%", 
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                              ),
                              progressColor: Theme.of(context).colorScheme.primary,
                              backgroundColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                              circularStrokeCap: CircularStrokeCap.round,
                            ),
                          ],
                        ),
                      ],
                    ),
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
                        ...selectedRecord.tasksWorkedOn.map((task) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle_outline, size: 16, color: Theme.of(context).colorScheme.secondary),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  task,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        )),
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
         final bool isSelected = DateUtils.isSameDay(date, _selectedDate);
         
         // Future Check
         final now = DateTime.now();
         final bool isFuture = date.isAfter(DateTime(now.year, now.month, now.day));

          final Color themeColor = Theme.of(context).colorScheme.primary; 

          // Size-based visualization logic
          double circleSize = 30.0; // Default fallback
          double fontSize = 12.0;

          if (hasActivity) {
             double goalRatio = settings.dailyGoalMinutes > 0 
                ? (record.minutesFocused / settings.dailyGoalMinutes) 
                : 1.0;
             
             // Min size 22 (smaller), Max size 55 (larger) for more contrast
             const double minSize = 22.0;
             const double maxSize = 55.0;
             
             // Interpolate
             double progress = goalRatio.clamp(0.0, 1.0);
             circleSize = minSize + (progress * (maxSize - minSize));
             
             // Scale font slightly with size
             fontSize = 11.0 + (progress * 5.0);
          } else if (isSelected) {
            circleSize = 40.0; // Standard selection size when empty
          } else {
             circleSize = 36.0; // Standard empty size
          }

          return GestureDetector(
            onTap: isFuture ? null : () { // Disable click for future
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
                  color: hasActivity ? themeColor : Colors.transparent, 
                  shape: BoxShape.circle,
                  border: isSelected 
                      ? Border.all(color: themeColor, width: 2) 
                      : (hasActivity ? null : Border.all(color: Colors.transparent)),
                ),
                child: Text(
                  "$day", 
                  style: TextStyle(
                    // Future days keep normal color
                    color: hasActivity ? Colors.white : (isSelected ? themeColor : Colors.grey), 
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
  
  // Removed _showDailyDetailsDialog as we use inline details now



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
                    max: 1440, // 24 hours
                    divisions: 47, // 30 min increments
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

  void _showShareDialog(BuildContext context, SettingsProvider settings, DailyRecord record, int focusedMinutes) {
    final GlobalKey boundaryKey = GlobalKey();
    final history = Provider.of<HistoryProvider>(context, listen: false);
    
    // Initial State
    String selectedRange = 'daily'; // 'daily', 'monthly', '6months', 'yearly'
    
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) {
          // Calculate Stats based on Range
          int displayMinutes = 0;
          int displayGoal = 0;
          String displayTitle = "";
          String displayDateLabel = "";
          ShareMode displayMode = ShareMode.daily;
          Map<DateTime, int>? periodData;
          
          final now = DateTime.now();
          
          if (selectedRange == 'daily') {
            displayMinutes = focusedMinutes;
            displayGoal = settings.dailyGoalMinutes; // Daily Goal relevant here
            displayTitle = settings.translate('statsDaily');
            displayDateLabel = _formatDate(_selectedDate, settings);
            displayMode = ShareMode.daily;
          } else if (selectedRange == 'monthly') {
            final start = DateTime(now.year, now.month, 1);
            final end = DateTime(now.year, now.month + 1, 0);
            displayMinutes = history.getStatsForPeriod(start, end);
            periodData = history.getDailyRecordsForPeriod(start, end);
            displayTitle = settings.translate('statsMonthly');
            displayDateLabel = _formatMonth(now, settings);
            displayMode = ShareMode.monthly;
          } else if (selectedRange == '6months') {
             final start = DateTime(now.year, now.month - 5, 1);
             final end = DateTime(now.year, now.month + 1, 0);
             displayMinutes = history.getStatsForPeriod(start, end);
             periodData = history.getDailyRecordsForPeriod(start, end);
             displayTitle = settings.translate('stats6Months');
             displayDateLabel = "${_formatMonth(start, settings)} - ${_formatMonth(end, settings)}";
             displayMode = ShareMode.heatmap;
          } else if (selectedRange == 'yearly') {
             final start = DateTime(now.year, 1, 1);
             final end = DateTime(now.year, 12, 31);
             displayMinutes = history.getStatsForPeriod(start, end);
             periodData = history.getDailyRecordsForPeriod(start, end);
             displayTitle = settings.translate('statsYearly');
             displayDateLabel = "${now.year}";
             displayMode = ShareMode.heatmap;
          }

          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(10),
            child: SingleChildScrollView( // Added scroll view for safety
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   // Controls
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedRange,
                        dropdownColor: Theme.of(context).cardColor,
                        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color, fontWeight: FontWeight.bold),
                        onChanged: (val) {
                          if (val != null) setState(() => selectedRange = val);
                        },
                        items: [
                          DropdownMenuItem(value: 'daily', child: Text(settings.translate('statsDaily'))),
                          DropdownMenuItem(value: 'monthly', child: Text(settings.translate('statsMonthly'))),
                          DropdownMenuItem(value: '6months', child: Text(settings.translate('stats6Months'))),
                          DropdownMenuItem(value: 'yearly', child: Text(settings.translate('statsYearly'))),
                        ],
                      ),
                    ),
                  ),

                  Stack(
                    children: [
                      RepaintBoundary(
                        key: boundaryKey,
                        child: ShareStatsCard(
                          focusedMinutes: displayMinutes,
                          goalMinutes: displayGoal,
                          dateLabel: displayDateLabel,
                          title: displayTitle,
                          settings: settings,
                          mode: displayMode,
                          periodData: periodData,
                        ),
                      ),
                       Positioned(
                        top: 0, 
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () async {
                      // 1. Capture Image
                      try {
                        final boundary = boundaryKey.currentContext?.findRenderObject() as rendering.RenderRepaintBoundary?;
                        if (boundary == null) return;

                        final image = await boundary.toImage(pixelRatio: 3.0);
                        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
                        final pngBytes = byteData?.buffer.asUint8List();

                        if (pngBytes != null) {
                          // 2. Save to Temp File
                          final directory = await getTemporaryDirectory();
                          final path = '${directory.path}/focus_stats_share.png';
                          final file = File(path);
                          await file.writeAsBytes(pngBytes);

                          // 3. Share
                          final xFile = XFile(path);
                          if (context.mounted) {
                            Navigator.pop(ctx); // Close dialog first
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
}
