import 'package:flutter/material.dart';
import 'package:muslim360/core/theme/fonts/app_text_styles.dart';
import 'package:muslim360/core/theme/style/app_colors.dart';

class NextPrayerProgress extends StatelessWidget {
  final double progress;
  final String prayerName;
  final String prayerTime;
  final String remainingTime;

  const NextPrayerProgress({
    super.key,
    required this.progress,
    required this.prayerName,
    required this.prayerTime,
    required this.remainingTime,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 220,
          height: 220,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 6,
            backgroundColor: AppColors.secondaryBackground,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
            strokeCap: StrokeCap.square,
          ),
        ),

        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.bottomNavBarBackground,
          ),
          padding: const EdgeInsets.all(35),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(prayerName, style: AppTextStyles.body30BoldWhite),
                const SizedBox(height: 8),
                Text(prayerTime, style: AppTextStyles.headline18W900Grey),
                const SizedBox(height: 8),
                Text(remainingTime, style: AppTextStyles.headline30W900Primary),
                Text('متبقي', style: AppTextStyles.body14W800Grey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
