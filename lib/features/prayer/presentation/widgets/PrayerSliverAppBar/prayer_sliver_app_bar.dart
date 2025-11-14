import 'package:flutter/material.dart';
import 'package:muslim360/core/theme/fonts/app_text_styles.dart';
import 'package:muslim360/core/theme/style/app_colors.dart';

class PrayerSliverAppBar extends StatelessWidget {
  const PrayerSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      snap: true,
      titleSpacing: 16,
      toolbarHeight: 50,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.scaffoldBackground,
      title: Text(
        'الصلاة',
        style: AppTextStyles.body.copyWith(
          color: AppColors.textWhite,
          fontWeight: FontWeight.w100,
          fontSize: 26,
        ),
      ),
      actionsPadding: EdgeInsets.only(left: 16),
      actions: [
        GestureDetector(
          child: Row(
            children: [
              Text(
                '0',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textGrey,
                  fontSize: 16,
                ),
              ),
              Icon(Icons.bolt_sharp, color: AppColors.textGrey, size: 33),
            ],
          ),
        ),
        // More
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.more_vert_sharp,
              color: AppColors.textGrey,
              size: 33,
            ),
          ),
        ),
      ],
    );
  }
}
