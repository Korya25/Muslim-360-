import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:muslim360/core/services/pref_keys.dart';
import 'package:muslim360/core/services/shared_pref.dart';
import 'package:muslim360/core/utils/failure.dart';
import 'package:muslim360/features/prayer/data/model/prayer_month.dart';

abstract class PrayerLocalDataSource {
  Future<Either<Failure, void>> saveMonth(PrayerMonth month);
  Future<Either<Failure, PrayerMonth>> getMonth();
}

class PrayerLocalDataSourceImpl implements PrayerLocalDataSource {
  final SharedPref sharedPref;

  PrayerLocalDataSourceImpl({required this.sharedPref});

  @override
  Future<Either<Failure, void>> saveMonth(PrayerMonth month) async {
    try {
      final jsonString = jsonEncode(month.toJson());
      await sharedPref.setString(PrefKeys.monthKey, jsonString);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PrayerMonth>> getMonth() async {
    try {
      final jsonString = sharedPref.getString(PrefKeys.monthKey);
      if (jsonString != null) {
        final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        final month = PrayerMonth.fromJson(jsonMap);
        return Right(month);
      } else {
        return Left(CacheFailure(message: 'No cached month found'));
      }
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
