import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/prayer/data/datasources/prayer_local_data_source.dart';
import '../../features/prayer/data/datasources/prayer_remote_data_source.dart';
import '../../features/prayer/data/repositories/prayer_repository_impl.dart';
import '../../features/prayer/domain/repositories/prayer_repository.dart';
import '../../features/prayer/domain/usecases/get_prayer_calendar.dart';
import '../../features/prayer/presentation/cubit/prayer_cubit.dart';
import '../routing/app_router.dart';
import '../services/shared_pref.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // External dependencies
  final sharedPref = SharedPref();
  await sharedPref.instantiatePreferences();
  locator.registerLazySingleton<SharedPref>(() => sharedPref);
  locator.registerLazySingleton<Dio>(() => Dio());

  // Routing
  locator.registerLazySingleton<AppRouter>(AppRouter.new);

  // Data sources
  locator.registerLazySingleton<PrayerRemoteDataSource>(
    () => PrayerRemoteDataSourceImpl(dio: locator<Dio>()),
  );

  locator.registerLazySingleton<PrayerLocalDataSource>(
    () => PrayerLocalDataSourceImpl(sharedPref: locator<SharedPref>()),
  );

  // Repository
  locator.registerLazySingleton<PrayerRepository>(
    () => PrayerRepositoryImpl(
      remoteDataSource: locator<PrayerRemoteDataSource>(),
      localDataSource: locator<PrayerLocalDataSource>(),
    ),
  );

  // Use cases
  locator.registerLazySingleton<GetPrayerCalendar>(
    () => GetPrayerCalendar(locator<PrayerRepository>()),
  );

  // Cubit
  locator.registerFactory<PrayerCubit>(
    () => PrayerCubit(getPrayerCalendar: locator<GetPrayerCalendar>()),
  );
}
