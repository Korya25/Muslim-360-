import 'package:dartz/dartz.dart';
import 'package:muslim360/core/failures/failures.dart';
import '../entities/prayer_calendar.dart';

abstract class PrayerRepository {
  Future<Either<Failure, PrayerCalendar>> getPrayerCalendar({
    required int year,
    required int month,
    required double latitude,
    required double longitude,
  });
}
