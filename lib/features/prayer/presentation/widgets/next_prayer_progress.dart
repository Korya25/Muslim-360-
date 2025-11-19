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
          width: 170,
          height: 170,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 4,
            backgroundColor: AppColors.secondaryBackground,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
            strokeCap: StrokeCap.round,
          ),
        ),

        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.bottomNavBarBackground,
          ),
          padding: const EdgeInsets.all(37),
          child: Column(
            spacing: 16,
            children: [
              Column(
                children: [
                  Text(prayerName, style: AppTextStyles.body24W700White),
                  Text(prayerTime, style: AppTextStyles.amiri18W600White200),
                ],
              ),

              Column(
                children: [
                  Text(remainingTime, style: AppTextStyles.head30W700Primary),
                  Text('متبقي', style: AppTextStyles.amiri16W600White180),
                ],
              ),
              SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
