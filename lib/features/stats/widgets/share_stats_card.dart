import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/widgets/glass_box.dart';
import '../../settings/settings_provider.dart';

enum ShareMode { daily, weekly, monthly, yearly }
enum ShareVisualType { calendar, chart, heatmap }

class ShareStatsCard extends StatelessWidget {
  final int focusedMinutes;
  final int goalMinutes; 
  final String dateLabel; 
  final String title;
  final SettingsProvider settings;
  final ShareMode mode;
  final ShareVisualType visualType;
  final Map<DateTime, int>? periodData; // Data for calendar/heatmap
  final DateTime referenceDate; // Anchor date for the view

  const ShareStatsCard({
    super.key,
    required this.focusedMinutes,
    required this.goalMinutes,
    required this.dateLabel,
    required this.title,
    required this.settings,
    required this.referenceDate,
    this.mode = ShareMode.daily,
    this.visualType = ShareVisualType.calendar,
    this.periodData,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    final isYearly = mode == ShareMode.yearly;

    // For Yearly mode, we want a taller card to accommodate the large heatmap.
    return Container(
      // Physical Width: 400 for yearly (wider), 350 for others
      width: isYearly ? 450 : 350, 
      // Physical Height: Dynamic for yearly, fixed for others
      height: isYearly ? null : 600,
      constraints: isYearly ? const BoxConstraints(minHeight: 800) : null,
      decoration: const BoxDecoration(
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
              mainAxisSize: MainAxisSize.min, // Allow shrinking for Yearly if needed, but usually expands
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.timer_outlined, color: Colors.white, size: 24),
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
                
                if (!isYearly) const Spacer(),
                if (isYearly) const SizedBox(height: 40),

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
                if (isYearly)
                   // Yearly content expands naturally
                   _buildMainContent(context, primaryColor)
                else
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
                          compact: isYearly,
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
                          compact: isYearly,
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

                if (!isYearly) const Spacer(),
                if (isYearly) const SizedBox(height: 40),
                
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
    if (periodData!.isEmpty) return "0.0";
    // Average over active days
    double avg = focusedMinutes / periodData!.length / 60;
    return avg.toStringAsFixed(1);
  }

  Widget _buildMainContent(BuildContext context, Color primaryColor) {
    if (mode == ShareMode.yearly) {
       // No FittedBox for Yearly, we want full resolution scale
       // But we need to constrain width to container width
       return _buildContentForMode(context, primaryColor);
    }

    return Container(
      constraints: const BoxConstraints(
        maxWidth: 300, 
        maxHeight: 300 
      ),
      child: FittedBox( 
        fit: BoxFit.contain, 
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
      case ShareMode.weekly:
        // Weekly is typically a chart (VisualType can force chart logic)
        return _buildWeeklyChart(primaryColor);
      case ShareMode.monthly:
        if (visualType == ShareVisualType.chart) {
           return _buildMonthlyLineChart(primaryColor);
        }
        return _buildMonthlyCalendar(context, primaryColor);
      case ShareMode.yearly:
        return _buildYearlyHeatmap(context, primaryColor);
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
    
    DateTime monthStart = DateTime(referenceDate.year, referenceDate.month, 1);
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
        SizedBox( 
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

  Widget _buildWeeklyChart(Color primaryColor) {
    // Ensure we have a full week of data (Mon-Sun) based on referenceDate
    final startOfWeek = referenceDate.subtract(Duration(days: referenceDate.weekday - 1));
    
    List<BarChartGroupData> barGroups = [];
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    for (int i = 0; i < 7; i++) {
      final date = startOfWeek.add(Duration(days: i));
      
      // Find data for this date
      int minutes = 0;
      if (periodData != null) {
        for (var k in periodData!.keys) {
           if (k.year == date.year && k.month == date.month && k.day == date.day) {
             minutes = periodData![k]!;
             break;
           }
        }
      }
      
      double yVal = minutes / 60.0;
      
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: yVal,
              color: primaryColor,
              width: 14,
              borderRadius: BorderRadius.circular(4),
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: (goalMinutes / 60).toDouble() > yVal ? (goalMinutes / 60).toDouble() * 1.2 : yVal + 1 + ((goalMinutes/60)*0.2), 
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      height: 200,
      width: 300,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceBetween,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                   if (value.toInt() >= 0 && value.toInt() < 7) {
                     return Padding(
                       padding: const EdgeInsets.only(top: 8.0),
                       child: Text(
                         days[value.toInt()], 
                         style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)
                       ),
                     );
                   }
                   return const SizedBox();
                },
                reservedSize: 24,
              ),
            ),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }

  Widget _buildMonthlyLineChart(Color primaryColor) {
     if (periodData == null || periodData!.isEmpty) return const SizedBox();

     var sortedKeys = periodData!.keys.toList()..sort();
     List<FlSpot> spots = [];
     
     double maxMinutes = 0;
     
     // IMPORTANT: We need continuous days for x-axis to make sense visually like a calendar month,
     // but line charts typically just plot points. 
     // For Monthly view, users expect Day 1..30/31.
     // Let's ensure we map x as Day of Month.
     
     // Removed unused monthStart
     final daysInMonth = DateUtils.getDaysInMonth(referenceDate.year, referenceDate.month);
     
     // Construct spots for every day to ensure '0' values are shown (Line goes down)
     for(int day=1; day <= daysInMonth; day++) {
        double val = 0;
        // Find if we have data
        for(var k in sortedKeys) {
          if (k.year == referenceDate.year && k.month == referenceDate.month && k.day == day) {
             val = (periodData![k] ?? 0).toDouble();
             break;
          }
        }
        if (val > maxMinutes) maxMinutes = val;
        spots.add(FlSpot(day.toDouble(), val));
     }

     return Container(
       height: 200,
       width: 300,
       padding: const EdgeInsets.only(right: 16, bottom: 10),
       child: LineChart(
         LineChartData(
           lineTouchData: const LineTouchData(enabled: false),
           gridData: FlGridData(
             show: true, 
             drawVerticalLine: false,
             getDrawingHorizontalLine: (value) => const FlLine(color: Colors.white10, strokeWidth: 1),
           ),
           titlesData: FlTitlesData(
             show: true,
             bottomTitles: AxisTitles(
               sideTitles: SideTitles(
                 showTitles: true,
                 interval: 5, // Show every 5th day to avoid crowding
                 getTitlesWidget: (value, meta) {
                    if (value % 5 == 0 || value == 1) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          value.toInt().toString(),
                          style: const TextStyle(color: Colors.white54, fontSize: 10),
                        ),
                      );
                    }
                    return const SizedBox();
                 },
                 reservedSize: 24,
               )
             ),
             leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
             topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
             rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
           ),
           borderData: FlBorderData(show: false),
           minX: 1,
           maxX: daysInMonth.toDouble(),
           minY: -0.5,
           maxY: maxMinutes * 1.25 + 10, // Headroom
           lineBarsData: [
             LineChartBarData(
               spots: spots,
               isCurved: true,
               color: primaryColor,
               barWidth: 3,
               isStrokeCapRound: true,
               dotData: FlDotData(show: false),
               belowBarData: BarAreaData(
                 show: true,
                 color: primaryColor.withOpacity(0.2),
                 gradient: LinearGradient(
                   begin: Alignment.topCenter,
                   end: Alignment.bottomCenter,
                   colors: [primaryColor.withOpacity(0.3), primaryColor.withOpacity(0.0)],
                 )
               ),
             ),
           ],
         ),
       ),
     );
  }


  Widget _buildYearlyHeatmap(BuildContext context, Color primaryColor) {
    if (periodData == null) return const SizedBox();
    
    // Yearly Heatmap: Single Stack Column for maximum visibility
    final year = referenceDate.year;
    
    return Column(
      children: [
        for (int month = 1; month <= 12; month++)
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0), // Spacing between months
            child: _buildMiniMonthGrid(context, primaryColor, year, month),
          ),
          
        // Legend
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Less", style: TextStyle(color: Colors.white38, fontSize: 10)),
            const SizedBox(width: 4),
            _buildHeatmapCell(Colors.white.withOpacity(0.05), size: 10),
            const SizedBox(width: 2),
            _buildHeatmapCell(primaryColor.withOpacity(0.3), size: 10),
            const SizedBox(width: 2),
            _buildHeatmapCell(primaryColor.withOpacity(0.6), size: 10),
            const SizedBox(width: 2),
            _buildHeatmapCell(primaryColor, size: 10),
            const SizedBox(width: 4),
            const Text("More", style: TextStyle(color: Colors.white38, fontSize: 10)),
          ],
        )
      ],
    );
  }

  Widget _buildMiniMonthGrid(BuildContext context, Color primaryColor, int year, int month) {
    DateTime monthStart = DateTime(year, month, 1);
    int daysInMonth = DateUtils.getDaysInMonth(year, month);
    int offset = monthStart.weekday - 1; // 0=Mon
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getMonthName(month), 
          style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold) 
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 400, // Full width utilization
          child: GridView.builder(
            shrinkWrap: true, 
            physics: const NeverScrollableScrollPhysics(), 
            itemCount: 42, // Fixed for alignment
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7, 
              mainAxisSpacing: 6.0, 
              crossAxisSpacing: 6.0,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (context, index) {
              if (index < offset || index >= offset + daysInMonth) {
                 return const SizedBox();
              }
              final day = index - offset + 1;
              final date = DateTime(year, month, day);
              
              int minutes = 0;
              for (var k in periodData!.keys) {
                 if (k.year == date.year && k.month == date.month && k.day == date.day) {
                   minutes = periodData![k]!;
                   break;
                 }
              }

               Color color = Colors.white.withOpacity(0.05);
               if (minutes > 0) {
                  double goalRatio = (minutes / (goalMinutes > 0 ? goalMinutes : 60));
                  if(goalRatio <= 0.25) color = primaryColor.withOpacity(0.3);
                  else if(goalRatio <= 0.50) color = primaryColor.withOpacity(0.5);
                  else if(goalRatio <= 0.75) color = primaryColor.withOpacity(0.7);
                  else color = primaryColor;
               }

               return Container(
                 decoration: BoxDecoration(
                   color: color,
                   borderRadius: BorderRadius.circular(4), // Slightly rounded for better aesthetics
                 ),
                 child: Tooltip(
                   message: "$day ${_getMonthName(month)}: $minutes m",
                   child: Center(
                     child: Text(
                       "$day",
                       style: TextStyle(
                         color: minutes > 0 ? Colors.white : Colors.white24,
                         fontSize: 12,
                         fontWeight: FontWeight.w500
                       ),
                     ),
                   )
                 ),
               );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeatmapCell(Color color, {double size = 10}) {
    return Container(width: size, height: size, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)));
  }

  String _getMonthName(int m) {
     const months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
     return months[m-1];
  }

  Widget _buildStatItem(BuildContext context, String value, String label, IconData icon, {bool compact = false}) {
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
