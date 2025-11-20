import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim360/features/prayer/data/repo/prayer_repository.dart';
import 'prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  final PrayerRepository repository;
  final double latitude;
  final double longitude;

  PrayerCubit({
    required this.repository,
    required this.latitude,
    required this.longitude,
  }) : super(PrayerInitial());

  /// Fetch today prayer from local or remote
  Future<void> fetchTodayPrayer() async {
    emit(PrayerLoading());

    final result = await repository.getTodayPrayer(
      latitude: latitude,
      longitude: longitude,
    );

    result.fold(
      (failure) => emit(PrayerError(failure.message)),
      (todayPrayer) => emit(PrayerLoaded(todayPrayer)),
    );
  }

  /// Refresh all data (reload month + next month)
  Future<void> refreshData() async {
    emit(PrayerLoading());

    try {
      await repository.refreshAll(latitude: latitude, longitude: longitude);

      // fetch today's after refresh
      await fetchTodayPrayer();
    } catch (e) {
      emit(PrayerError(e.toString()));
    }
  }
}
