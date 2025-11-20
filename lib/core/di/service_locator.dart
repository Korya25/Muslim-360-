import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../services/shared_pref.dart';

final GetIt sl = GetIt.instance;

Future<void> setupLocator() async {
  // External dependencies
  final sharedPref = SharedPref();
  await sharedPref.instantiatePreferences();
  sl.registerLazySingleton<SharedPref>(() => sharedPref);
  // Core
  sl.registerLazySingleton<Dio>(() => Dio());
}
