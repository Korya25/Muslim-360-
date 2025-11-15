import '../../domain/entities/prayer_calendar.dart';

abstract class PrayerState {
  const PrayerState();
}

class PrayerInitial extends PrayerState {
  const PrayerInitial();
}

class PrayerLoading extends PrayerState {
  const PrayerLoading();
}

class PrayerLoaded extends PrayerState {
  final PrayerCalendar calendar;

  const PrayerLoaded(this.calendar);
}

class PrayerError extends PrayerState {
  final String message;

  const PrayerError(this.message);
}
