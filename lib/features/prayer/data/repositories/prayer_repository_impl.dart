import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
import '../../domain/entities/prayer_calendar.dart';
import '../../domain/repositories/prayer_repository.dart';
import '../datasources/prayer_local_data_source.dart';
import '../datasources/prayer_remote_data_source.dart';

class PrayerRepositoryImpl implements PrayerRepository {
  final PrayerRemoteDataSource remoteDataSource;
  final PrayerLocalDataSource localDataSource;

  PrayerRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, PrayerCalendar>> getPrayerCalendar({
    required int year,
    required int month,
    required double latitude,
    required double longitude,
  }) async {
    final cachedResult = await localDataSource.getCachedPrayerCalendar(
      year: year,
      month: month,
      latitude: latitude,
      longitude: longitude,
    );
    final cachedCalendar = cachedResult.getOrElse(() => null);
    if (cachedCalendar != null) return Right(cachedCalendar);

    final remoteResult = await remoteDataSource.getPrayerCalendar(
      year: year,
      month: month,
      latitude: latitude,
      longitude: longitude,
    );

    return await remoteResult.fold(
      (remoteFailure) async {
        final cachedResult = await localDataSource.getCachedPrayerCalendar(
          year: year,
          month: month,
          latitude: latitude,
          longitude: longitude,
        );
        final cachedCalendar = cachedResult.getOrElse(() => null);
        if (cachedCalendar != null) return Right(cachedCalendar);
        return Left(remoteFailure);
      },
      (remoteCalendar) async {
        await localDataSource.cachePrayerCalendar(
          year: year,
          month: month,
          latitude: latitude,
          longitude: longitude,
          calendar: remoteCalendar,
        );
        return Right(remoteCalendar);
      },
    );
  }
}
