import 'package:flutter/material.dart';
import 'package:muslim360/core/theme/fonts/app_text_styles.dart';
import 'package:muslim360/core/theme/style/app_colors.dart';
import 'package:muslim360/features/prayer/data/model/prayer_day.dart';

class NextPrayerProgress extends StatefulWidget {
  final PrayerDay day;

  const NextPrayerProgress({super.key, required this.day});

  @override
  State<NextPrayerProgress> createState() => _NextPrayerProgressState();
}

class _NextPrayerProgressState extends State<NextPrayerProgress> {
  late Prayer nextPrayer;
  late DateTime nextPrayerTime;
  late DateTime previousPrayerTime;
  late String remainingTime;

  @override
  void initState() {
    super.initState();
    _calculateTimes();
    Future.delayed(Duration.zero, _startTimer);
  }

  void _startTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      setState(_calculateTimes);
      return true;
    });
  }

  void _calculateTimes() {
    final now = DateTime.now();
    final prayers = widget.day.prayers;
    DateTime? next;
    DateTime? prev;
    Prayer? nextPray;

    for (var prayer in prayers) {
      final timeStr = widget.day.prayerTimesClean[prayer.name] ?? '00:00';
      final parts = timeStr.split(":");
      if (parts.length < 2) continue;
      final time = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );

      if (time.isAfter(now) && next == null) {
        next = time;
        nextPray = prayer;
      }
      if (time.isBefore(now)) prev = time;
    }

    if (next == null && prayers.isNotEmpty) {
      final fajrTime = widget.day.prayerTimesClean['الفجر']!;
      final p = fajrTime.split(":");
      next = DateTime(
        now.year,
        now.month,
        now.day + 1,
        int.parse(p[0]),
        int.parse(p[1]),
      );
      nextPray = prayers.firstWhere((p) => p.name == 'الفجر');

      final ishaTime = widget.day.prayerTimesClean['العشاء']!;
      final ish = ishaTime.split(":");
      prev = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(ish[0]),
        int.parse(ish[1]),
      );
    }

    previousPrayerTime = prev ?? now;
    nextPrayerTime = next ?? now.add(const Duration(hours: 1));
    nextPrayer = nextPray ?? prayers.first;

    final diff = nextPrayerTime.difference(now);
    remainingTime =
        "${diff.inHours.toString().padLeft(2, '0')}:${(diff.inMinutes % 60).toString().padLeft(2, '0')}:${(diff.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  double get progress {
    final totalSeconds = nextPrayerTime
        .difference(previousPrayerTime)
        .inSeconds;
    final elapsedSeconds = DateTime.now()
        .difference(previousPrayerTime)
        .inSeconds;
    if (totalSeconds <= 0) return 1.0;
    return (elapsedSeconds / totalSeconds).clamp(0.001, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final formattedNext =
        widget.day.prayerTimesCleanForDisplay[nextPrayer.name] ?? '00:00 ص';

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 190,
          height: 190,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 4,
            backgroundColor: AppColors.secondaryBackground,
            valueColor: AlwaysStoppedAnimation(AppColors.primaryGreen),
            strokeCap: StrokeCap.round,
          ),
        ),
        Container(
          height: 180,
          width: 180,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.bottomNavBarBackground,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Text(
                      nextPrayer.name,
                      style: AppTextStyles.body24W700White.copyWith(
                        fontSize: 26,
                      ),
                    ),
                    Text(
                      formattedNext,
                      style: AppTextStyles.amiri18W600White200.copyWith(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    Text(
                      remainingTime,
                      style: AppTextStyles.head30W700Primary.copyWith(
                        fontSize: 28,
                      ),
                    ),
                    Text('متبقي', style: AppTextStyles.amiri16W600White180),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
