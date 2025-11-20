import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:muslim360/core/utils/failure.dart';
import 'package:muslim360/features/prayer/data/model/prayer_month.dart';

abstract class PrayerRemoteDataSource {
  Future<Either<Failure, PrayerMonth>> getPrayerMonth({
    required int year,
    required int month,
    required double latitude,
    required double longitude,
  });
}

class PrayerRemoteDataSourceImpl implements PrayerRemoteDataSource {
  final Dio dio;
  static const String baseUrl = 'https://api.aladhan.com/v1';

  PrayerRemoteDataSourceImpl({required this.dio});

  @override
  Future<Either<Failure, PrayerMonth>> getPrayerMonth({
    required int year,
    required int month,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await dio.get(
        '$baseUrl/calendar/$year/$month',
        queryParameters: {'latitude': latitude, 'longitude': longitude},
      );

      if (response.statusCode == 200) {
        final data = PrayerMonth.fromJson(response.data);
        return Right(data);
      } else {
        return Left(
          ServerFailure(
            message: 'Server returned status code ${response.statusCode}',
          ),
        );
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
