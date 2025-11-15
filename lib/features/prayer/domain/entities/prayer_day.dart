import 'date_info.dart';
import 'meta_info.dart';
import 'prayer_timing.dart';

class PrayerDay {
  final PrayerTiming timings;
  final DateInfo date;
  final MetaInfo meta;

  const PrayerDay({
    required this.timings,
    required this.date,
    required this.meta,
  });
}
