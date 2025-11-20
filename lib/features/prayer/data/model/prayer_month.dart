import 'package:muslim360/features/prayer/data/model/prayer_day.dart';

class PrayerMonth {
  final int code;
  final String status;
  final List<PrayerDay> days;

  PrayerMonth({required this.code, required this.status, required this.days});

  factory PrayerMonth.fromJson(Map<String, dynamic> json) {
    return PrayerMonth(
      code: json["code"],
      status: json["status"],
      days: List<PrayerDay>.from(
        json["data"].map((x) => PrayerDay.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "status": status,
      "data": days.map((day) => day.toJson()).toList(),
    };
  }
}
