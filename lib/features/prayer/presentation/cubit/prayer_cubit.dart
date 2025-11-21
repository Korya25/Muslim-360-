import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim360/features/prayer/data/repo/prayer_repository.dart';
import 'package:muslim360/core/services/location/location_service.dart';
import 'prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  final PrayerRepository repository;
  final LocationService locationService;

  PrayerCubit({required this.repository, required this.locationService})
    : super(PrayerInitial()) {
    init();
  }

  Future<void> init() async {
    try {
      final cachedPrayer = await repository.getTodayPrayerFromCache();
      if (cachedPrayer != null) {
        emit(PrayerLoaded(cachedPrayer));
        return;
      }

      emit(PrayerLoading());

      final position = await locationService.getCurrentLocation(
        onError: (err) {
          print('Location error: $err');
        },
      );

      if (position == null) {
        emit(PrayerError('الموقع غير متاح'));
        return;
      }

      await fetchTodayPrayer(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      emit(PrayerError(e.toString()));
    }
  }

  Future<void> fetchTodayPrayer({
    required double latitude,
    required double longitude,
    bool isRefresh = false,
  }) async {
    if (!isRefresh) emit(PrayerLoading());

    final result = await repository.getTodayPrayer(
      latitude: latitude,
      longitude: longitude,
    );

    result.fold(
      (failure) => emit(PrayerError(failure.message)),
      (todayPrayer) => emit(PrayerLoaded(todayPrayer)),
    );
  }

  Future<void> refreshData() async {
    try {
      // استخدم القيم المخزنة فقط بدون إعادة طلب الموقع
      final cached = await locationService.getCachedLocation();
      if (cached == null) {
        emit(PrayerError('الموقع غير متاح'));
        return;
      }

      await repository.refreshAll(
        latitude: cached['latitude']!,
        longitude: cached['longitude']!,
      );

      await fetchTodayPrayer(
        latitude: cached['latitude']!,
        longitude: cached['longitude']!,
        isRefresh: true,
      );
    } catch (e) {
      if (state is PrayerLoaded) return;
      emit(PrayerError(e.toString()));
    }
  }
}
