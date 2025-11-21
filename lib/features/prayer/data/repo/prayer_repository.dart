import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:muslim360/core/services/sharedpref/pref_keys.dart';
import 'package:muslim360/core/services/sharedpref/shared_pref.dart';
import 'package:muslim360/core/utils/failure.dart';
import 'package:muslim360/features/prayer/data/datasource/prayer_local_data_source.dart';
import 'package:muslim360/features/prayer/data/datasource/prayer_remote_data_source.dart';
import 'package:muslim360/features/prayer/data/model/prayer_day.dart';
import 'package:muslim360/features/prayer/data/model/prayer_month.dart';

class PrayerRepository {
  final PrayerRemoteDataSource remoteDataSource;
  final PrayerLocalDataSource localDataSource;
  final SharedPref sharedPref;

  PrayerRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.sharedPref,
  });
  Future<PrayerDay?> getTodayPrayerFromCache() async {
    final cachedString = sharedPref.getString(PrefKeys.monthKey);
    if (cachedString == null) return null;

    final List<dynamic> jsonList = jsonDecode(cachedString);
    final months = jsonList.map((e) => PrayerMonth.fromJson(e)).toList();

    final today = DateTime.now();

    final monthData = months.firstWhere(
      (m) => m.days.isNotEmpty && _monthOfDay(m.days[0]) == today.month,
      orElse: () => PrayerMonth(code: 0, status: 'Empty', days: []),
    );

    if (monthData.days.isEmpty) return null;

    final day = monthData.days.cast<PrayerDay?>().firstWhere(
      (d) => _dayOfDate(d!) == today.day,
      orElse: () => null,
    );

    return day;
  }

  /// ================================
  /// تحميل شهر من الريموت وحفظه في اللوكال
  /// ================================
  Future<PrayerMonth> _fetchAndCacheMonth({
    int? year,
    int? month,
    required double latitude,
    required double longitude,
  }) async {
    final now = DateTime.now();
    final targetYear = year ?? now.year;
    final targetMonth = month ?? now.month;

    final remoteResult = await remoteDataSource.getPrayerMonth(
      year: targetYear,
      month: targetMonth,
      latitude: latitude,
      longitude: longitude,
    );

    return remoteResult.fold(
      (failure) {
        // بدل ما نرمي Exception، نتحقق أولًا من Local Storage
        final cachedString = sharedPref.getString(PrefKeys.monthKey);
        if (cachedString != null) {
          final List<dynamic> jsonList = jsonDecode(cachedString);
          final months = jsonList.map((e) => PrayerMonth.fromJson(e)).toList();
          final monthData = months.firstWhere(
            (m) => m.days.isNotEmpty && _monthOfDay(m.days[0]) == targetMonth,
            orElse: () => PrayerMonth(code: 0, status: 'Empty', days: []),
          );
          if (monthData.days.isNotEmpty) {
            return monthData;
          }
        }

        // إذا لا يوجد، نعيد فشل ServerFailure بدل Exception
        throw ServerFailure(message: failure.message);
      },
      (monthData) async {
        // تخزين البيانات كما كان
        final cachedString = sharedPref.getString(PrefKeys.monthKey);
        List<PrayerMonth> months = [];
        if (cachedString != null) {
          final List<dynamic> jsonList = jsonDecode(cachedString);
          months = jsonList.map((e) => PrayerMonth.fromJson(e)).toList();
        }

        months.add(monthData);
        if (months.length > 2) months = months.sublist(months.length - 2);

        final jsonToSave = jsonEncode(months.map((e) => e.toJson()).toList());
        await sharedPref.setString(PrefKeys.monthKey, jsonToSave);

        return monthData;
      },
    );
  }

  /// ================================
  /// الحصول على اليوم الحالي من اللوكال أو الريموت
  /// ================================
  Future<Either<Failure, PrayerDay>> getTodayPrayer({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final today = DateTime.now();

      // جلب الشهور المخزنة
      final cachedString = sharedPref.getString(PrefKeys.monthKey);
      List<PrayerMonth> months = [];
      if (cachedString != null) {
        final List<dynamic> jsonList = jsonDecode(cachedString);
        months = jsonList.map((e) => PrayerMonth.fromJson(e)).toList();
      }

      // البحث عن الشهر الحالي
      PrayerMonth? monthData = months.firstWhere(
        (m) => m.days.isNotEmpty && _monthOfDay(m.days[0]) == today.month,
        orElse: () => PrayerMonth(code: 0, status: 'Empty', days: []),
      );

      // إذا لم يكن موجودًا، نحمله من الريموت
      if (monthData.days.isEmpty) {
        monthData = await _fetchAndCacheMonth(
          year: today.year,
          month: today.month,
          latitude: latitude,
          longitude: longitude,
        );
      }

      // البحث عن اليوم الحالي
      final day = monthData.days.firstWhere(
        (d) => _dayOfDate(d) == today.day,
        orElse: () => throw CacheFailure(message: "اليوم الحالي غير موجود"),
      );

      return Right(day);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  /// ================================
  /// تحميل الشهر القادم وتخزينه
  /// ================================
  Future<Either<Failure, PrayerMonth>> fetchNextMonth({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final today = DateTime.now();
      int nextMonth = today.month + 1;
      int year = today.year;

      if (nextMonth > 12) {
        nextMonth = 1;
        year += 1;
      }

      final monthData = await _fetchAndCacheMonth(
        year: year,
        month: nextMonth,
        latitude: latitude,
        longitude: longitude,
      );

      return Right(monthData);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  /// ================================
  /// تحديث البيانات بالكامل (إعادة تحميل كل شيء من الريموت)
  /// ================================
  Future<void> refreshAll({
    required double latitude,
    required double longitude,
  }) async {
    final today = DateTime.now();
    await _fetchAndCacheMonth(
      year: today.year,
      month: today.month,
      latitude: latitude,
      longitude: longitude,
    );
    await fetchNextMonth(latitude: latitude, longitude: longitude);
  }

  /// ================================
  /// مساعدة: الحصول على رقم اليوم من PrayerDay
  /// ================================
  int _dayOfDate(PrayerDay day) {
    final greg = day.date["gregorian"];
    return int.parse(greg["day"]);
  }

  /// ================================
  /// مساعدة: الحصول على رقم الشهر من PrayerDay
  /// ================================
  int _monthOfDay(PrayerDay day) {
    final greg = day.date["gregorian"];
    return int.parse(greg["month"]["number"].toString());
  }
}
