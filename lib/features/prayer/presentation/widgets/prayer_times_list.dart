import 'package:flutter/material.dart';
import 'package:muslim360/features/prayer/presentation/data/prayer_data.dart';
import 'package:muslim360/features/prayer/presentation/widgets/prayer_time_item.dart';

class PrayerTimesList extends StatelessWidget {
  final Map<String, String> prayerTimes;
  final String? currentPrayerKey;

  const PrayerTimesList({
    super.key,
    required this.prayerTimes,
    this.currentPrayerKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: fakePrayers.map((prayer) {
        final prayerTime = prayerTimes[prayer.timeKey] ?? '--:--';
        final isActive = currentPrayerKey == prayer.timeKey;
        return PrayerTimeItem(
          prayer: prayer,
          prayerTime: prayerTime,
          isActive: isActive,
        );
      }).toList(),
    );
  }
}
