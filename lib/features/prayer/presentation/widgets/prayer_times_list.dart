// prayer_times_list.dart
import 'package:flutter/material.dart';
import 'package:muslim360/features/prayer/data/model/prayer_day.dart';
import 'package:muslim360/features/prayer/presentation/widgets/prayer_time_item.dart';

class PrayerTimesList extends StatelessWidget {
  final PrayerDay day;

  const PrayerTimesList({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    final prayers = day.prayers;
    final nextPrayerName = day.nextPrayer.name;

    return Column(
      children: prayers.map((prayer) {
        return PrayerTimeItem(
          prayer: prayer,
          prayerTime: day.prayerTimesCleanForDisplay[prayer.name] ?? '',
          // ignore: unrelated_type_equality_checks
          isActive: prayer.name == nextPrayerName,
        );
      }).toList(),
    );
  }
}
