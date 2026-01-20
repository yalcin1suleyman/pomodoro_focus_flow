import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../core/widgets/glass_box.dart';
import '../../settings/settings_provider.dart';



enum ShareMode { daily, monthly, heatmap }

class ShareStatsCard extends StatelessWidget {
  final int focusedMinutes;
  final int goalMinutes; 
  final String dateLabel; 
  final String title;
  final SettingsProvider settings;
  final ShareMode mode;
  final Map<DateTime, int>? periodData; // Data for calendar/heatmap

  const ShareStatsCard({
    super.key,
    required this.focusedMinutes,
    required this.goalMinutes,
    required this.dateLabel,
    required this.title,
    required this.settings,
    this.mode = ShareMode.daily,
    this.periodData,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Container(
      width: 350,
      height: 600,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1a1f3c), // Dark blue/purple background
            Color(0xFF0F172A),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background Elements
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.2),
                boxShadow: [
                  BoxShadow(color: primaryColor.withOpacity(0.3), blurRadius: 50, spreadRadius: 10)
                ]
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.secondary.withOpacity(0.1),
                boxShadow: [
                  BoxShadow(color: theme.colorScheme.secondary.withOpacity(0.2), blurRadius: 40, spreadRadius: 5)
                ]
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.timer_outlined, color: Colors.white, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      "Pomodoro Master",
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                
                const Spacer(),

                // Title & Date
                Text(
                  title,
                  style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  dateLabel,
                  style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 30),

                // Main Visual Content Visualization
                Expanded(
                  flex: 3,
                  child: Center(
                    child: _buildMainContent(context, primaryColor),
                  ),
                ),

                const SizedBox(height: 30),

                // Stats Detail Card
                GlassBox(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.05),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(
                          context,
                          (focusedMinutes / 60).toStringAsFixed(1),
                          settings.translate('hours'),
                          Icons.access_time_filled,
                        ),
                        Container(width: 1, height: 30, color: Colors.white24),
                        // For daily mode show goal, for others show daily average
                        _buildStatItem(
                          context,
                          mode == ShareMode.daily 
                              ? (goalMinutes / 60).toStringAsFixed(1) 
                              : _calculateDailyAverage(),
                          mode == ShareMode.daily 
                              ? settings.translate('dailyGoal') 
                              : settings.translate('average'),
                          mode == ShareMode.daily ? Icons.flag : Icons.analytics,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Footer Message
                Text(
                   "\"${settings.translate('shareMessage')}\"",
                   textAlign: TextAlign.center,
                   style: TextStyle(
                     color: Colors.white.withOpacity(0.9),
                     fontSize: 16,
                     fontStyle: FontStyle.italic,
                     fontWeight: FontWeight.w500,
                   ),
                ),

                const Spacer(),
                const Text("Pomodoro Master by Yalcin Studio", style: TextStyle(color: Colors.white38, fontSize: 11, letterSpacing: 1)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _calculateDailyAverage() {
    if (periodData == null || periodData!.isEmpty) return "0.0";
    // We average over the number of days that actually had activity OR total days in period?
    // Usually daily average implies total / days in range. 
    // Here we will use periodData length (days with activity) or a better approximation passed in?
    // For simplicity, let's use days with activity for "Active Average" or Total/Days in Month.
    // Given we only have periodData (activity map), let's average over active days to be more motivating?
    // OR: focusedMinutes / keys.length
    if (periodData!.isEmpty) return "0.0";
    double avg = focusedMinutes / periodData!.length / 60;
    return avg.toStringAsFixed(1);
  }

  Widget _buildMainContent(BuildContext context, Color primaryColor) {
    // Constraint container defines the available space on screen
    return Container(
      constraints: const BoxConstraints(maxWidth: 300, maxHeight: 300),
      // FittedBox scales the child to fit into the container
      child: FittedBox( 
        fit: BoxFit.scaleDown,
        // Child layouts with fixed width but unbounded height allowed (scaled down if too tall)
        child: SizedBox(
           width: 300,
           child: _buildContentForMode(context, primaryColor),
        ),
      ),
    );
  }

  Widget _buildContentForMode(BuildContext context, Color primaryColor) {
    switch (mode) {
      case ShareMode.daily:
        return _buildDailyCircle(primaryColor);
      case ShareMode.monthly:
        return _buildMonthlyCalendar(context, primaryColor);
      case ShareMode.heatmap:
        return _buildHeatmapGrid(context, primaryColor);
    }
  }

  Widget _buildDailyCircle(Color primaryColor) {
    final double progressPercent = goalMinutes > 0 
        ? (focusedMinutes / goalMinutes).clamp(0.0, 1.0)
        : 1.0;

    return CircularPercentIndicator(
      radius: 75.0,
      lineWidth: 15.0,
      percent: progressPercent,
      center: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${(progressPercent * 100).toInt()}%",
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32), 
            ),
            Text(
              settings.translate('dailyGoal'),
              style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 10),
            ),
          ],
        ),
      ),
      progressColor: primaryColor,
      backgroundColor: Colors.white.withOpacity(0.1),
      circularStrokeCap: CircularStrokeCap.round,
      animation: false, 
    );
  }

  Widget _buildMonthlyCalendar(BuildContext context, Color primaryColor) {
    if (periodData == null) return const SizedBox();
    if (periodData!.isEmpty) return const Center(child: Icon(Icons.calendar_month, size: 60, color: Colors.white24));

    DateTime firstDate = periodData!.keys.reduce((a, b) => a.isBefore(b) ? a : b);
    DateTime monthStart = DateTime(firstDate.year, firstDate.month, 1);
    int daysInMonth = DateUtils.getDaysInMonth(monthStart.year, monthStart.month);
    int offset = monthStart.weekday - 1;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ["M", "T", "W", "T", "F", "S", "S"]
              .map((e) => Text(e, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)))
              .toList(),
        ),
        const SizedBox(height: 8),
        SizedBox( // Constrain grid height slightly just in case
          height: 180, 
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemCount: daysInMonth + offset,
            itemBuilder: (context, index) {
              if (index < offset) return const SizedBox();
              
              final day = index - offset + 1;
              final date = DateTime(monthStart.year, monthStart.month, day);
              
              bool isActive = false;
              int minutes = 0;
              for (var k in periodData!.keys) {
                 if (k.year == date.year && k.month == date.month && k.day == date.day) {
                   isActive = true;
                   minutes = periodData![k]!;
                   break;
                 }
              }
              
              double opacity = 0.1;
              if (isActive) {
                opacity = (0.3 + (minutes / 240) * 0.7).clamp(0.3, 1.0);
              }

              return Container(
                decoration: BoxDecoration(
                  color: isActive ? primaryColor.withOpacity(opacity) : Colors.white.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: isActive 
                    ? Text("$day", style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold))
                    : null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeatmapGrid(BuildContext context, Color primaryColor) {
    if (periodData == null || periodData!.isEmpty) {
        return const Center(child: Icon(Icons.grid_view, size: 60, color: Colors.white24));
    }
    
    // Sort dates
    var sortedKeys = periodData!.keys.toList()..sort();
    
    // Determine range
    DateTime start = sortedKeys.first;
    DateTime end = sortedKeys.last;
    int totalDays = end.difference(start).inDays + 1;
    
    return Column(
      mainAxisSize: MainAxisSize.min, // Shrink wrap
      children: [
        // Github-style squares
        Wrap(
          spacing: 3, // Reduced spacing
          runSpacing: 3, 
          alignment: WrapAlignment.center,
          children: List.generate(totalDays > 84 ? 84 : totalDays, (index) { 
             // Simple visualization
             return Container(
               width: 10, 
               height: 10,
               decoration: BoxDecoration(
                 color: primaryColor.withOpacity(0.4), 
                 borderRadius: BorderRadius.circular(2),
               ),
             );
          }),
        ),
        
        const SizedBox(height: 16),
        
        // Monthly Bars
        Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           crossAxisAlignment: CrossAxisAlignment.end,
           children: _buildMonthlyBars(primaryColor),
        )
      ],
    );
  }

  List<Widget> _buildMonthlyBars(Color color) {
     // Aggregating data by month
     Map<int, int> monthlyTotals = {};
     if (periodData != null) {
       for (var entry in periodData!.entries) {
          int month = entry.key.month;
          monthlyTotals[month] = (monthlyTotals[month] ?? 0) + entry.value;
       }
     }
     
     // Find max for scaling
     int max = 1;
     if (monthlyTotals.isNotEmpty) {
       max = monthlyTotals.values.reduce((a, b) => a > b ? a : b);
     }
     if (max == 0) max = 1;

     // Sort months
     var months = monthlyTotals.keys.toList()..sort();
     
     return months.map((m) {
        double heightFactor = monthlyTotals[m]! / max;
        // Min height for visibility
        if (heightFactor < 0.1 && monthlyTotals[m]! > 0) heightFactor = 0.1;
        
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
             Text(
               "${(monthlyTotals[m]! / 60).toStringAsFixed(0)}h", 
               style: const TextStyle(color: Colors.white70, fontSize: 10)
             ),
             const SizedBox(height: 4),
             Container(
               width: 30, // Bar width
               height: 150 * heightFactor, // Scale height
               decoration: BoxDecoration(
                 color: color.withOpacity(0.8),
                 borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
               ),
             ),
             const SizedBox(height: 8),
             Text(
               _getMonthName(m), 
               style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)
             ),
          ],
        );
     }).toList();
  }
  
  String _getMonthName(int m) {
     const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
     return months[m-1];
  }

  Widget _buildStatItem(BuildContext context, String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
