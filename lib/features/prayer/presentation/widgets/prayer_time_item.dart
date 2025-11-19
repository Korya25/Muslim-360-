import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:muslim360/core/theme/fonts/app_text_styles.dart';
import 'package:muslim360/core/theme/style/app_colors.dart';
import 'package:muslim360/features/prayer/presentation/data/prayer_data.dart';

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

  void _toggleExpand() {
    setState(() => _isExpanded = !_isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    final prayer = widget.prayer;
    final isActive = widget.isActive;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- Icon ---
              SizedBox(
                height: 40,
                width: 40,
                child: Lottie.asset(prayer.iconPath, fit: BoxFit.contain),
              ),

              const SizedBox(width: 12),

              // --- Name ---
              Text(
                prayer.name,
                style: isActive
                    ? AppTextStyles.cairo16W700Primary
                    : AppTextStyles.cairo16W600White,
              ),

              const SizedBox(width: 12),

              // --- Expand button (only if sunnah exists) ---
              if (prayer.sunnah != null)
                GestureDetector(
                  onTap: _toggleExpand,
                  child: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: isActive
                        ? AppColors.primaryGreen
                        : AppColors.textWhite.withOpacity(0.7),
                    size: 20,
                  ),
                ),

              const Spacer(),

              // --- Time ---
              Text(
                widget.prayerTime,
                style: isActive
                    ? AppTextStyles.amiri15W900Primary
                    : AppTextStyles.amiri15W700White,
              ),
            ],
          ),
        ),

        // --- Sunnah Content ---
        if (_isExpanded && prayer.sunnah != null)
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 12,
              top: 0,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: AppColors.secondaryBackground,
                  width: 1,
                ),
              ),
              child: Text(
                prayer.sunnah!,
                style: AppTextStyles.cairo12W600Primary,
              ),
            ),
          ),
      ],
    );
  }
}
