// prayer_time_item.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:muslim360/core/theme/fonts/app_text_styles.dart';
import 'package:muslim360/core/theme/style/app_colors.dart';
import 'package:muslim360/features/prayer/data/model/prayer_day.dart';

class PrayerTimeItem extends StatefulWidget {
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
  State<PrayerTimeItem> createState() => _PrayerTimeItemState();
}

class _PrayerTimeItemState extends State<PrayerTimeItem> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isActive;
  }

  @override
  void didUpdateWidget(covariant PrayerTimeItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      setState(() => _isExpanded = widget.isActive);
    }
  }

  void _toggleExpand() {
    setState(() => _isExpanded = !_isExpanded);
    HapticFeedback.mediumImpact();
  }

  @override
  Widget build(BuildContext context) {
    final prayer = widget.prayer;
    final isActive = widget.isActive;
    final hasSunnah = prayer.sunnah != null && prayer.sunnah!.isNotEmpty;

    return GestureDetector(
      onTap: _toggleExpand,

      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 48,
                  width: 48,
                  child: Lottie.asset(prayer.iconPath, fit: BoxFit.contain),
                ),
                const SizedBox(width: 12),
                Text(
                  prayer.name,
                  style: isActive
                      ? AppTextStyles.cairo16W700Primary
                      : AppTextStyles.cairo16W600White,
                ),
                const SizedBox(width: 12),
                if (hasSunnah)
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: isActive
                        ? AppColors.primaryGreen
                        : AppColors.textWhite.withOpacity(0.7),
                    size: 20,
                  ),
                const Spacer(),
                Text(
                  widget.prayerTime,
                  style: isActive
                      ? AppTextStyles.amiri15W900Primary
                      : AppTextStyles.amiri15W700White,
                ),
              ],
            ),
          ),
          if (_isExpanded && hasSunnah)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.textPrimary.withAlpha(150),
                  width: 1,
                ),
              ),
              child: Text(
                prayer.sunnah!,
                style: AppTextStyles.cairo12W600Primary.copyWith(
                  color: AppColors.textGrey,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
