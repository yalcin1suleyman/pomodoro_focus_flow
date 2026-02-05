
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../settings/settings_provider.dart';
import '../history_provider.dart';
import 'package:intl/intl.dart';

enum StoryMode { daily, weekly, monthly, yearly }

class StoryStatsCard extends StatelessWidget {
  final StoryMode mode;
  final DateTime date; // Reference date (Day for Daily/Weekly, Month for Monthly/Yearly)
  final SettingsProvider settings;
  final HistoryProvider historyProvider;
  final DailyRecord? dailyRecord; // Only for Daily mode optimization

  const StoryStatsCard({
    super.key,
    required this.mode,
    required this.date,
    required this.settings,
    required this.historyProvider,
    this.dailyRecord,
  });

  @override
  Widget build(BuildContext context) {
    // Standard Story Resolution aspect ratio container
    return Container(
      width: 400,
      height: 711, // 9:16
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A), 
        image: DecorationImage(
           image: AssetImage('assets/images/story_bg_placeholder.png'),
           fit: BoxFit.cover,
           opacity: 0.2
        )
      ),
      child: Stack(
         children: [
           // 1. Background Gradients
           Positioned.fill(
             child: Container(
               decoration: const BoxDecoration(
                 gradient: LinearGradient(
                   begin: Alignment.topCenter,
                   end: Alignment.bottomCenter,
                   colors: [
                     Color(0xFF1a1f3c),
                     Color(0xFF000000),
                   ]
                 )
               ),
             )
           ),
           // Ambient Light Orb
           Positioned(
             top: -100,
             left: -100,
             child: Container(
               width: 500,
               height: 500,
               decoration: BoxDecoration(
                 shape: BoxShape.circle,
                 color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                 boxShadow: [
                   BoxShadow(
                     color: Theme.of(context).colorScheme.primary.withOpacity(0.2), 
                     blurRadius: 100, 
                     spreadRadius: 20
                   )
                 ]
               ),
             ),
           ),

           // 2. Main Content
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 60),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 // HEADER
                 _buildHeader(context),
                 const SizedBox(height: 40),

                 // DYNAMIC CONTENT BASED ON MODE
                 Expanded(
                   child: _buildBody(context),
                 ),

                 // FOOTER
                 const SizedBox(height: 20),
                 _buildFooter(),
               ],
             ),
           ),
         ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    String title = "";
    switch (mode) {
      case StoryMode.daily:
        title = DateFormat('d MMMM yyyy').format(date).toUpperCase();
        break;
      case StoryMode.weekly:
        final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
        final endOfWeek = startOfWeek.add(const Duration(days: 6));
        title = "${DateFormat('d MMM').format(startOfWeek)} - ${DateFormat('d MMM').format(endOfWeek)}".toUpperCase();
        break;
      case StoryMode.monthly:
        title = DateFormat('MMMM yyyy').format(date).toUpperCase();
        break;
      case StoryMode.yearly:
        title = DateFormat('yyyy').format(date).toUpperCase();
        break;
    }

    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6), 
            letterSpacing: 2.0,
            fontSize: 14,
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 10),
        Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Icon(Icons.timer_outlined, color: Theme.of(context).colorScheme.primary, size: 24),
             const SizedBox(width: 8),
             const Text(
               "Pomodoro Master",
               style: TextStyle(
                 color: Colors.white,
                 fontSize: 20,
                 fontWeight: FontWeight.bold,
                 letterSpacing: 1.0, 
                 fontFamily: 'Manrope'
               ),
             ),
           ],
         ),
      ],
    );
  }

  Widget _buildFooter() {
    return Text(
      "\"Stay Focused, Stay Unstoppable.\"",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white.withOpacity(0.5),
        fontStyle: FontStyle.italic,
        fontSize: 14,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    switch (mode) {
      case StoryMode.daily:
        return _buildDailyView(context);
      case StoryMode.weekly:
        return _buildWeeklyView(context);
      case StoryMode.monthly:
        return _buildMonthlyView(context);
      case StoryMode.yearly:
        return _buildYearlyView(context);
    }
  }

  // ===========================================================================
  // 1. DAILY VIEW
  // ===========================================================================
  Widget _buildDailyView(BuildContext context) {
    // If dailyRecord is null (shouldn't be for daily mode), try fetch
    final record = dailyRecord ?? historyProvider.getRecord(date);
    final int focusedMinutes = record.minutesFocused;
    final int goalMinutes = record.targetMinutes ?? settings.dailyGoalMinutes;
    final int sessionCount = (focusedMinutes / settings.pomodoroMinutes).ceil(); // Approx
    
    // Find top task
    String topTask = "General Focus";
    if (record.tasksWorkedOn.isNotEmpty) {
      topTask = record.tasksWorkedOn.first; // Simplified: take first
    }

    final double progress = goalMinutes > 0 ? (focusedMinutes / goalMinutes).clamp(0.0, 1.0) : 0.0;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         const Spacer(),
         // Big Time
         Text(
           (focusedMinutes / 60).toStringAsFixed(1),
           style: const TextStyle(
             color: Colors.white,
             fontSize: 120, 
             fontWeight: FontWeight.w900,
             height: 0.9
           ),
         ),
         Text(
           settings.translate('hours').toUpperCase(),
           style: TextStyle(
             color: primaryColor,
             fontSize: 24,
             fontWeight: FontWeight.bold,
             letterSpacing: 4.0
           ),
         ),
         const SizedBox(height: 40),
         
         // Stats Grid
         Container(
           padding: const EdgeInsets.all(20),
           decoration: BoxDecoration(
             color: Colors.white.withOpacity(0.05),
             borderRadius: BorderRadius.circular(20),
             border: Border.all(color: Colors.white10)
           ),
           child: Column(
             children: [
               _buildStatRow(context, Icons.check_circle_outline, "${(progress * 100).toInt()}%", "Goal Completed"),
               const Divider(color: Colors.white10, height: 30),
               _buildStatRow(context, Icons.refresh, "$sessionCount", "Sessions"),
               const Divider(color: Colors.white10, height: 30),
               _buildStatRow(context, Icons.star_outline, topTask, "Top Focus"),
             ],
           ),
         ),
         const Spacer(),
      ],
    );
  }

  Widget _buildStatRow(BuildContext context, IconData icon, String value, String label) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary, size: 28),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
          ],
        )
      ],
    );
  }

  // ===========================================================================
  // 2. WEEKLY VIEW (Bar Chart)
  // ===========================================================================
  Widget _buildWeeklyView(BuildContext context) {
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    final primaryColor = Theme.of(context).colorScheme.primary;
    
    // Calculate max for scale
    int maxMinutes = 0;
    for (int i = 0; i < 7; i++) {
      final day = startOfWeek.add(Duration(days: i));
      final rec = historyProvider.getRecord(day);
      if (rec.minutesFocused > maxMinutes) maxMinutes = rec.minutesFocused;
    }
    if (maxMinutes < settings.dailyGoalMinutes) maxMinutes = settings.dailyGoalMinutes; // Minimum scale

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Text(
          "WEEKLY FOCUS",
          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        const SizedBox(height: 40),
        
        // Bar Chart
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(7, (index) {
              final day = startOfWeek.add(Duration(days: index));
              final rec = historyProvider.getRecord(day);
              final minutes = rec.minutesFocused;
              final dayGoal = rec.targetMinutes ?? settings.dailyGoalMinutes;
              
              // Opacity logic: Darker if closer to goal
              double goalRatio = dayGoal > 0 ? (minutes / dayGoal).clamp(0.0, 1.0) : 0.0;
              double opacity = 0.3 + (goalRatio * 0.7); // 0.3 to 1.0

              // Height logic
              double heightFactor = maxMinutes > 0 ? (minutes / maxMinutes) : 0.0;
              if (minutes == 0) heightFactor = 0.02; // Tiny dot for empty

              final dayName = DateFormat('E').format(day)[0]; // M, T, W...

              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Minutes Label (if significant)
                  if (minutes > 30) 
                    Text(
                      "${(minutes/60).toStringAsFixed(1)}", 
                      style: TextStyle(color: Colors.white54, fontSize: 10)
                    ),
                  const SizedBox(height: 4),
                  // BAR
                  Container(
                    width: 24,
                    height: (400 * heightFactor).clamp(10.0, 400.0), // Max height 400
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(opacity),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: goalRatio >= 1.0 ? [
                        BoxShadow(color: primaryColor.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, -2))
                      ] : null
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Day Label
                  Text(
                    dayName, 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                  ),
                ],
              );
            }),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  // ===========================================================================
  // 3. MONTHLY VIEW (Classic Logic)
  // ===========================================================================
  Widget _buildMonthlyView(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("MONTHLY OVERVIEW", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: _buildMonthGrid(context, date, 45, true), // Large grid
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  // ===========================================================================
  // 4. YEARLY VIEW (Vertical Heatmap - GitHub Style)
  // ===========================================================================
  // ===========================================================================
  // 4. YEARLY VIEW (Compact Heatmap - 14 Columns / 2 Weeks per Row)
  // ===========================================================================
  // ===========================================================================
  // 4. YEARLY VIEW (Vertical Ruler Heatmap)
  // ===========================================================================
  Widget _buildYearlyView(BuildContext context) {
    final int year = date.year;
    final DateTime startOfYear = DateTime(year, 1, 1);
    final DateTime endOfYear = DateTime(year + 1, 1, 1);
    final int daysInYear = endOfYear.difference(startOfYear).inDays; 
    
    // Total weeks needed: 53 or 54 usually to cover partials
    final int totalWeeks = ((daysInYear + startOfYear.weekday - 1) / 7).ceil();
    
    final primaryColor = Theme.of(context).colorScheme.primary;

    // Helper to find which week index a month starts in
    Map<int, String> monthStarts = {};
    for (int m = 1; m <= 12; m++) {
      final firstOfMonth = DateTime(year, m, 1);
      final dayOfYear = firstOfMonth.difference(startOfYear).inDays;
      final weekIndex = (dayOfYear + startOfYear.weekday - 1) ~/ 7;
      monthStarts[weekIndex] = DateFormat('MMM').format(firstOfMonth);
    }

    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          "$year JOURNEY", 
          style: TextStyle(
            color: Colors.white, 
            fontSize: 24, 
            fontWeight: FontWeight.w900, 
            letterSpacing: 2.0
          )
        ),
        const SizedBox(height: 20),
        
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 // 1. LEFT RULER (Month Labels)
                 SizedBox(
                   width: 30,
                   child: LayoutBuilder(
                     builder: (ctx, constraints) {
                       final double totalHeight = constraints.maxHeight;
                       final double weekHeight = totalHeight / totalWeeks;
                       
                       return Stack(
                         children: monthStarts.entries.map((entry) {
                           return Positioned(
                             top: entry.key * weekHeight,
                             left: 0,
                             child: Text(
                               entry.value.toUpperCase(),
                               style: TextStyle(
                                 color: Colors.white.withOpacity(0.5), 
                                 fontSize: 10, 
                                 fontWeight: FontWeight.bold
                               )
                             ),
                           );
                         }).toList(),
                       );
                     },
                   ),
                 ),
                 
                 const SizedBox(width: 8),

                 // 2. MAIN HEATMAP (7 Cols x 53 Rows)
                 Expanded(
                   child: LayoutBuilder(
                      builder: (ctx, constraints) {
                        // Calculate exact size to fit height
                        final double availableHeight = constraints.maxHeight;
                        final double verticalGap = 2.0;
                        final double availableForCells = availableHeight - ((totalWeeks - 1) * verticalGap);
                        final double cellHeight = availableForCells / totalWeeks;
                        
                        // We use the cellHEIGHT to determine aspect ratio, 
                        // as width will just fill expand.
                        // Actually, GridView asks for Ratio = Width / Height.
                        final double cellWidth = (constraints.maxWidth - (6 * 2)) / 7; // Approx
                        
                        // To ensure it fits exactly vertically, we need checks.
                        // Safe bet: standard aspect with shrinkWrap might overflow if not careful.
                        // Better: Use calculated Ratio.
                        
                        final double childRatio = cellWidth / cellHeight;
                        
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: verticalGap,
                            childAspectRatio: childRatio, 
                          ),
                          itemCount: totalWeeks * 7,
                          itemBuilder: (ctx, index) {
                             final int weekIndex = index ~/ 7;
                             final int dayInfo = index % 7; // 0=Mon
                             
                             // Calculate Date
                             // StartDate weekday: e.g. Wed (3).
                             // Grid 0 (Mon) -> -2 days from Start.
                             
                             final int dayOffset = index - (startOfYear.weekday - 1);
                             final DateTime cellDate = startOfYear.add(Duration(days: dayOffset));
                             
                             if (cellDate.year != year) return const SizedBox();

                             final record = historyProvider.getRecord(cellDate);
                             final minutes = record.minutesFocused;
                             final goal = record.targetMinutes ?? settings.dailyGoalMinutes;

                             if (minutes == 0) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.03),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                );
                             }

                             double ratio = goal > 0 ? (minutes / goal).clamp(0.0, 1.0) : 0.0;
                             double opacity = 0.3 + (ratio * 0.7);

                             return Container(
                               decoration: BoxDecoration(
                                 color: primaryColor.withOpacity(opacity),
                                 borderRadius: BorderRadius.circular(2),
                               ),
                             );
                          },
                        );
                      }
                   ),
                 ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 20),
        // Legend
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendDot(Colors.white.withOpacity(0.03), "0"),
            const SizedBox(width: 8),
            _buildLegendDot(primaryColor.withOpacity(0.3), "Start"),
            const SizedBox(width: 8),
            _buildLegendDot(primaryColor, "Goal"),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildLegendDot(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 10, height: 10, 
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10)),
      ],
    );
  }



  // Helper for Monthly/Yearly Grids
  Widget _buildMonthGrid(BuildContext context, DateTime monthDate, double baseSize, bool showLabels) {
    final daysInMonth = DateUtils.getDaysInMonth(monthDate.year, monthDate.month);
    final firstWeekday = DateTime(monthDate.year, monthDate.month, 1).weekday; // 1=Mon
    final offset = firstWeekday - 1;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Center(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: daysInMonth + offset,
        itemBuilder: (ctx, i) {
          if (i < offset) return const SizedBox();
          final day = i - offset + 1;
          final dayDate = DateTime(monthDate.year, monthDate.month, day);
          final record = historyProvider.getRecord(dayDate);
          
          // Logic:
          // 1. Goal Met -> Solid
          // 2. Focused > 0 -> Hollow ring, stroke width/size based on amount? OR Just ring.
          // 3. 0 -> Dot.

          final goal = record.targetMinutes ?? settings.dailyGoalMinutes;
          bool isMet = record.minutesFocused >= goal && record.minutesFocused > 0;
          bool hasActivity = record.minutesFocused > 0;

          if (isMet) {
             return Container(
               decoration: BoxDecoration(shape: BoxShape.circle, color: primaryColor),
             );
          } else if (hasActivity) {
             // Ring
             return Container(
               decoration: BoxDecoration(
                 shape: BoxShape.circle, 
                 border: Border.all(color: primaryColor.withOpacity(0.6), width: 1.5)
               ),
             );
          } else {
             // Empty dot
             return UnconstrainedBox(
               child: Container(
                 width: 3, height: 3,
                 decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
               ),
             );
          }
        },
      ),
    );
  }
}
