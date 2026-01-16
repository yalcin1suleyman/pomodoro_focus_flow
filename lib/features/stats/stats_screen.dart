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
  DateTime _selectedDate = DateTime.now();
  
  // Rotating motivational quotes
  final List<String> _enQuotes = [
    "Focus is the key to success.",
    "One pomodoro at a time.",
    "Small steps, big results.",
    "Keep pushing forward!",
    "Your future is created by what you do today.",
    "Stay consistent, stay focused.",
    "Deep work matters.",
  ];
  
  final List<String> _trQuotes = [
    "Odaklanmak başarının anahtarıdır.",
    "Her seferinde bir pomodoro.",
    "Küçük adımlar, büyük sonuçlar.",
    "İlerlemeye devam et!",
    "Geleceğin, bugün yaptıklarınla şekillenir.",
    "İstikrarlı ol, odaklan.",
    "Derin çalışma önemlidir.",
  ];

  String _getMotivationQuote(SettingsProvider settings) {
    // Simple rotation based on day of year to vary daily
    int dayOfYear = int.parse("${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}"); 
    // Or just pick random? Let's pick based on day so it stays same for the day.
    // Actually simplicity:
    final quotes = settings.language == 'tr' ? _trQuotes : _enQuotes;
    return quotes[DateTime.now().day % quotes.length];
  }

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
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                                style: Theme.of(context).textTheme.titleMedium
                              ),
                              const SizedBox(height: 10),
                              
                              if (isSelectedToday)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: InkWell(
                                    onTap: () => _showGoalDialog(context, settings),
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3)),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.edit, size: 16, color: Theme.of(context).primaryColor),
                                          const SizedBox(width: 8),
                                          Text(
                                            "${settings.translate('dailyGoal')}: ${(settings.dailyGoalMinutes / 60).toStringAsFixed(1)}h",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              
                              const SizedBox(height: 10),
                              Text("${(focusedMinutes / 60).toStringAsFixed(1)}h", 
                                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold)),

                              Text(isSelectedToday ? settings.translate('inProgress') : settings.translate('completed'), style: TextStyle(color: Colors.grey)),
                              
                              // Notes or Quote
                              const SizedBox(height: 12),
                              if (selectedRecord.note != null && selectedRecord.note!.isNotEmpty)
                                Text(
                                  "\"${selectedRecord.note}\"",
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 16, // Increased Size
                                  ),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                )
                              else if (isSelectedToday)
                                Text(
                                  _getMotivationQuote(settings),
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontStyle: FontStyle.italic,
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16, // Increased Size
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
                          ),
                        ),
                        CircularPercentIndicator(
                          radius: 60.0,
                          lineWidth: 12.0,
                          percent: progressPercent,
                          center: isSelectedToday 
                              ? Icon(Icons.check, size: 40, color: Theme.of(context).colorScheme.primary)
                              : Text("${(progressPercent * 100).toInt()}%", style: const TextStyle(fontWeight: FontWeight.bold)),
                          progressColor: Theme.of(context).colorScheme.primary, // Consistent color
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
             
             // Min size 28 (fits text), Max size 54 (slightly larger than before)
             const double minSize = 28.0;
             const double maxSize = 54.0;
             
             // Interpolate
             double progress = goalRatio.clamp(0.0, 1.0);
             circleSize = minSize + (progress * (maxSize - minSize));
             
             // Scale font slightly with size
             fontSize = 12.0 + (progress * 4.0);
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
