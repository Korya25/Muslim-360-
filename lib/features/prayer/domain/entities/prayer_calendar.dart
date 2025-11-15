import 'prayer_day.dart';

class PrayerCalendar {
  final int code;
  final String status;
  final List<PrayerDay> data;

  const PrayerCalendar({
    required this.code,
    required this.status,
    required this.data,
  });
}
