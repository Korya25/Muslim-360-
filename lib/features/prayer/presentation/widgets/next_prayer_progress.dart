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
  late String remainingTime;

  @override
  void initState() {
    super.initState();
    _updateRemainingTime();
    _startTimer();
  }

  void _startTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      setState(_updateRemainingTime);
      return true;
    });
  }

  void _updateRemainingTime() {
    remainingTime = widget.day.remainingTimeFormatted;
  }

  @override
  Widget build(BuildContext context) {
    final nextPrayer = widget.day.nextPrayer;
    final progress = widget.day.progressToNextPrayer;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 4,
            backgroundColor: AppColors.secondaryBackground,
            valueColor: AlwaysStoppedAnimation(AppColors.primaryGreen),
            strokeCap: StrokeCap.round,
          ),
        ),
        Container(
          height: 140,
          width: 140,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.bottomNavBarBackground,
          ),
          child: Center(
            child: Column(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(nextPrayer.name, style: AppTextStyles.body22W700White),
                Column(
                  children: [
                    Text(remainingTime, style: AppTextStyles.head24W700Primary),
                    Text('متبقي', style: AppTextStyles.amiri16W600White180),
                  ],
                ),
                SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
