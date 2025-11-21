import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:muslim360/core/services/shared_pref.dart';
import 'package:muslim360/features/prayer/data/datasource/prayer_local_data_source.dart';
import 'package:muslim360/features/prayer/data/datasource/prayer_remote_data_source.dart';
import 'package:muslim360/features/prayer/data/repo/prayer_repository.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // External dependencies
  final sharedPref = SharedPref();
  await sharedPref.instantiatePreferences();
  sl.registerLazySingleton<SharedPref>(() => sharedPref);

  sl.registerLazySingleton<Dio>(() => Dio());

  // Data sources
  sl.registerLazySingleton<PrayerRemoteDataSource>(
    () => PrayerRemoteDataSourceImpl(dio: sl<Dio>()),
  );
  sl.registerLazySingleton<PrayerLocalDataSource>(
    () => PrayerLocalDataSourceImpl(sharedPref: sl<SharedPref>()),
  );

  // Repository
  sl.registerLazySingleton<PrayerRepository>(
    () => PrayerRepository(
      remoteDataSource: sl<PrayerRemoteDataSource>(),
      localDataSource: sl<PrayerLocalDataSource>(),
      sharedPref: sl<SharedPref>(),
    ),
  );
}
