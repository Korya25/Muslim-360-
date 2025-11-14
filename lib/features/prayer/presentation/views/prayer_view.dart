import 'package:flutter/material.dart';
import 'package:muslim360/core/theme/style/app_colors.dart';
import 'package:muslim360/features/prayer/presentation/widgets/PrayerSliverAppBar/prayer_sliver_app_bar.dart';

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
            delegate: _PinnedHeaderDelegate(
              child: Container(
                height: 70,
                color: AppColors.bottomNavBarBackground,
                alignment: Alignment.center,
                child: const Text(
                  "هذا الجزء ثابت لا يتحرك",
                  style: TextStyle(color: AppColors.textWhite, fontSize: 18),
                ),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.bottomNavBarBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  "عنصر رقم ${index + 1}",
                  style: const TextStyle(color: AppColors.textGrey),
                ),
              );
            }, childCount: 20),
          ),
        ],
      ),
    );
  }
}

/// ⭐ Delegate خاص بتثبيت الودجت
class _PinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _PinnedHeaderDelegate({required this.child});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
