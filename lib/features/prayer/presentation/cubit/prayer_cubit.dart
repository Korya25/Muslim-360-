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

  Future<void> fetchTodayPrayer({bool isRefresh = false}) async {
    if (!isRefresh) {
      emit(PrayerLoading());
    }

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
      await repository.refreshAll(latitude: latitude, longitude: longitude);

      await fetchTodayPrayer(isRefresh: true);
    } catch (e) {
      if (state is PrayerLoaded) return;
      emit(PrayerError(e.toString()));
    }
  }
}
