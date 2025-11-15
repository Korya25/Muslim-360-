import '../../domain/entities/prayer_calendar.dart';
import 'prayer_day_model.dart';

class PrayerCalendarModel extends PrayerCalendar {
  const PrayerCalendarModel({
    required super.code,
    required super.status,
    required super.data,
  });

  factory PrayerCalendarModel.fromJson(Map<String, dynamic> json) {
    return PrayerCalendarModel(
      code: json['code'] as int,
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => PrayerDayModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'data': data.map((e) => (e as PrayerDayModel).toJson()).toList(),
    };
  }
}
