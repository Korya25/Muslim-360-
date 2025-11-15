import '../../domain/entities/prayer_timing.dart';

class PrayerTimingModel extends PrayerTiming {
  const PrayerTimingModel({
    required super.fajr,
    required super.sunrise,
    required super.dhuhr,
    required super.asr,
    required super.sunset,
    required super.maghrib,
    required super.isha,
    required super.imsak,
    required super.midnight,
    required super.firstthird,
    required super.lastthird,
  });

  factory PrayerTimingModel.fromJson(Map<String, dynamic> json) {
    return PrayerTimingModel(
      fajr: json['Fajr'] as String,
      sunrise: json['Sunrise'] as String,
      dhuhr: json['Dhuhr'] as String,
      asr: json['Asr'] as String,
      sunset: json['Sunset'] as String,
      maghrib: json['Maghrib'] as String,
      isha: json['Isha'] as String,
      imsak: json['Imsak'] as String,
      midnight: json['Midnight'] as String,
      firstthird: json['Firstthird'] as String,
      lastthird: json['Lastthird'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Fajr': fajr,
      'Sunrise': sunrise,
      'Dhuhr': dhuhr,
      'Asr': asr,
      'Sunset': sunset,
      'Maghrib': maghrib,
      'Isha': isha,
      'Imsak': imsak,
      'Midnight': midnight,
      'Firstthird': firstthird,
      'Lastthird': lastthird,
    };
  }
}
