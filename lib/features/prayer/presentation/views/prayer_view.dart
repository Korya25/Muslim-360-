import 'package:flutter/material.dart';
import 'package:muslim360/core/theme/style/app_colors.dart';
import 'package:muslim360/features/prayer/presentation/widgets/SliverAppBar/prayer_sliver_app_bar.dart';
import 'package:muslim360/features/prayer/presentation/widgets/SliverPersistentHeader/pinned_header_delegate.dart';

class PrayerView extends StatelessWidget {
  const PrayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          PrayerSliverAppBar(),

          SliverPersistentHeader(
            pinned: true,
            delegate: PinnedHeaderDelegate(
              child: Container(
                color: AppColors.bottomNavBarBackground,
                alignment: Alignment.center,
                child: const Text(
                  "",
                  style: TextStyle(color: AppColors.textWhite, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
