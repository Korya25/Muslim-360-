import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/failures/failures.dart';
import '../models/prayer_calendar_model.dart';

abstract class PrayerRemoteDataSource {
  Future<Either<Failure, PrayerCalendarModel>> getPrayerCalendar({
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
  Future<Either<Failure, PrayerCalendarModel>> getPrayerCalendar({
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
        return Right(
          PrayerCalendarModel.fromJson(response.data as Map<String, dynamic>),
        );
      } else {
        return Left(ServerFailure('حدث خطأ في الخادم: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return Left(TimeoutFailure());
        case DioExceptionType.connectionError:
          return Left(NetworkFailure());
        default:
          return Left(NetworkFailure(e.message ?? 'خطأ في الاتصال بالشبكة'));
      }
    } catch (_) {
      return Left(UnknownFailure());
    }
  }
}
