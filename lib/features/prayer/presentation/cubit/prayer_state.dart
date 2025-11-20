import 'package:equatable/equatable.dart';
import 'package:muslim360/features/prayer/data/model/prayer_day.dart';

abstract class PrayerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PrayerInitial extends PrayerState {}

class PrayerLoading extends PrayerState {}

class PrayerLoaded extends PrayerState {
  final PrayerDay todayPrayer;

  PrayerLoaded(this.todayPrayer);

  @override
  List<Object?> get props => [todayPrayer];
}

class PrayerError extends PrayerState {
  final String message;

  PrayerError(this.message);

  @override
  List<Object?> get props => [message];
}
