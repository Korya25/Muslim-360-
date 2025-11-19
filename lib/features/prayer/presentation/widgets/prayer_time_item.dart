// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:muslim360/core/theme/fonts/app_text_styles.dart';
import 'package:muslim360/core/theme/style/app_colors.dart';
import 'package:muslim360/features/prayer/presentation/data/prayer_data.dart';

class PrayerTimeItem extends StatelessWidget {
  final Prayer prayer;
  final String prayerTime;
  final bool isActive;

  const PrayerTimeItem({
    super.key,
    required this.prayer,
    required this.prayerTime,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: isActive
            ? Border.symmetric(
                vertical: BorderSide(color: AppColors.primaryGreen),
              )
            : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Lottie.asset(prayer.iconPath, height: 35, fit: BoxFit.fill),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            prayer.name,
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.textWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (prayer.sunnah != null) ...[
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryGreen.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: AppColors.primaryGreen.withOpacity(
                                    0.5,
                                  ),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                prayer.sunnah!,
                                style: AppTextStyles.body.copyWith(
                                  color: AppColors.primaryGreen,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                prayerTime,
                style: AppTextStyles.headline18W900Grey.copyWith(
                  fontSize: 15,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
