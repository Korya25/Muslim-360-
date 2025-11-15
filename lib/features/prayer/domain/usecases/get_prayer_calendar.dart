import 'package:dartz/dartz.dart';
import 'package:muslim360/core/failures/failures.dart';
import '../entities/prayer_calendar.dart';
import '../repositories/prayer_repository.dart';

class GetPrayerCalendar {
  final PrayerRepository repository;

  GetPrayerCalendar(this.repository);

  Future<Either<Failure, PrayerCalendar>> call({
    required int year,
    required int month,
    required double latitude,
    required double longitude,
  }) async {
    return await repository.getPrayerCalendar(
      year: year,
      month: month,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
