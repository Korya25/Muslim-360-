import 'package:flutter/material.dart';
import 'package:muslim360/core/theme/fonts/app_text_styles.dart';
import 'package:muslim360/core/theme/style/app_colors.dart';

class NextPrayerProgress extends StatefulWidget {
  final Map<String, String> prayerTimes;

  const NextPrayerProgress({super.key, required this.prayerTimes});

  @override
  State<NextPrayerProgress> createState() => _NextPrayerProgressState();
}

class _NextPrayerProgressState extends State<NextPrayerProgress> {
  late String nextPrayerName;
  late DateTime nextPrayerTime;
  late DateTime previousPrayerTime;
  late String remainingTime;

  final List<String> arabicOrder = [
    "الفجر",
    "الشروق",
    "الظهر",
    "العصر",
    "المغرب",
    "العشاء",
  ];

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
    DateTime? next;
    DateTime? prev;
    String? nextName;

    for (final prayer in arabicOrder) {
      final raw = widget.prayerTimes[prayer];
      if (raw == null) continue;

      final parts = raw.split(":");
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
        nextName = prayer;
      }
      if (time.isBefore(now)) {
        prev = time;
      }
    }

    if (next == null) {
      final fajr = widget.prayerTimes["الفجر"];
      if (fajr != null) {
        final p = fajr.split(":");
        next = DateTime(
          now.year,
          now.month,
          now.day + 1,
          int.parse(p[0]),
          int.parse(p[1]),
        );
        nextName = "الفجر";
      }

      final isha = widget.prayerTimes["العشاء"];
      if (isha != null) {
        final ish = isha.split(":");
        prev = DateTime(
          now.year,
          now.month,
          now.day,
          int.parse(ish[0]),
          int.parse(ish[1]),
        );
      }
    }

    previousPrayerTime = prev ?? now;
    nextPrayerTime = next ?? now.add(const Duration(hours: 1));
    nextPrayerName = nextName ?? "الفجر";

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
        "${nextPrayerTime.hour.toString().padLeft(2, '0')}:${nextPrayerTime.minute.toString().padLeft(2, '0')}";

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
          //padding: const EdgeInsets.all(33),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Text(
                      nextPrayerName,
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
