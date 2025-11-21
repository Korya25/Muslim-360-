import 'package:flutter/material.dart';
import 'package:muslim360/core/theme/style/app_colors.dart';

class PrayerLoadingSkeleton extends StatelessWidget {
  const PrayerLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 5),

          _shimmerBox(height: 14, width: 130),
          const SizedBox(height: 6),
          _shimmerBox(height: 12, width: 100),

          const SizedBox(height: 22),

          _circleSkeleton(),

          const SizedBox(height: 24),

          ...List.generate(
            5,
            (i) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: _prayerItemSkeleton(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerBox({required double height, required double width}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.grey.withAlpha(50),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _circleSkeleton() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: AppColors.grey.withAlpha(50),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: AppColors.grey.withAlpha(50),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  // عنصر صلاة كامل (icon + name + time)
  Widget _prayerItemSkeleton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // icon + name placeholder
        Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.grey.withAlpha(50),
              ),
            ),
            const SizedBox(width: 12),
            _shimmerBox(height: 14, width: 60),
          ],
        ),

        // time placeholder
        _shimmerBox(height: 14, width: 50),
      ],
    );
  }
}
