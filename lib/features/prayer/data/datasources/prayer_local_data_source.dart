import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../../../core/services/pref_keys.dart';
import '../../../../core/services/shared_pref.dart';
import '../../../../core/failures/failures.dart';
import '../models/prayer_calendar_model.dart';

abstract class PrayerLocalDataSource {
  Future<Either<Failure, PrayerCalendarModel?>> getCachedPrayerCalendar({
    required int year,
    required int month,
    required double latitude,
    required double longitude,
  });

  Future<Either<Failure, void>> cachePrayerCalendar({
    required int year,
    required int month,
    required double latitude,
    required double longitude,
    required PrayerCalendarModel calendar,
  });
}

class PrayerLocalDataSourceImpl implements PrayerLocalDataSource {
  final SharedPref sharedPref;

  PrayerLocalDataSourceImpl({required this.sharedPref});

  String _getCacheKey(int year, int month, double latitude, double longitude) {
    return '${PrefKeys.prayerCalendarCachePrefix}_${year}_${month}_${latitude}_$longitude';
  }

  @override
  Future<Either<Failure, PrayerCalendarModel?>> getCachedPrayerCalendar({
    required int year,
    required int month,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final cacheKey = _getCacheKey(year, month, latitude, longitude);
      final cachedData = sharedPref.getString(cacheKey);
      if (cachedData != null) {
        final jsonData = json.decode(cachedData) as Map<String, dynamic>;
        return Right(PrayerCalendarModel.fromJson(jsonData));
      }
      return const Right(null);
    } catch (_) {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, void>> cachePrayerCalendar({
    required int year,
    required int month,
    required double latitude,
    required double longitude,
    required PrayerCalendarModel calendar,
  }) async {
    try {
      final cacheKey = _getCacheKey(year, month, latitude, longitude);
      final jsonData = json.encode(calendar.toJson());
      await sharedPref.setString(cacheKey, jsonData);
      return const Right(null);
    } catch (_) {
      return const Right(null);
    }
  }
}
