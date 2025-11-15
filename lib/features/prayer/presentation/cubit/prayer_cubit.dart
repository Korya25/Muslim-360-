import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_prayer_calendar.dart';
import 'prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  final GetPrayerCalendar getPrayerCalendar;

  PrayerCubit({required this.getPrayerCalendar}) : super(const PrayerInitial());

  Future<void> loadPrayerCalendar({
    required int year,
    required int month,
    required double latitude,
    required double longitude,
  }) async {
    emit(const PrayerLoading());

    final result = await getPrayerCalendar(
      year: year,
      month: month,
      latitude: latitude,
      longitude: longitude,
    );

    result.fold(
      (failure) => emit(PrayerError(failure.message)),
      (calendar) => emit(PrayerLoaded(calendar)),
    );
  }
}
