import '../../domain/entities/prayer_day.dart';
import 'date_info_model.dart';
import 'meta_info_model.dart';
import 'prayer_timing_model.dart';

class PrayerDayModel extends PrayerDay {
  const PrayerDayModel({
    required super.timings,
    required super.date,
    required super.meta,
  });

  factory PrayerDayModel.fromJson(Map<String, dynamic> json) {
    return PrayerDayModel(
      timings: PrayerTimingModel.fromJson(json['timings'] as Map<String, dynamic>),
      date: DateInfoModel.fromJson(json['date'] as Map<String, dynamic>),
      meta: MetaInfoModel.fromJson(json['meta'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timings': (timings as PrayerTimingModel).toJson(),
      'date': (date as DateInfoModel).toJson(),
      'meta': (meta as MetaInfoModel).toJson(),
    };
  }
}

