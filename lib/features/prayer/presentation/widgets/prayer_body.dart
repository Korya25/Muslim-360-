import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim360/features/prayer/presentation/cubit/prayer_cubit.dart';
import 'package:muslim360/features/prayer/presentation/cubit/prayer_state.dart';
import 'package:muslim360/features/prayer/presentation/widgets/hijri_gregorian_date.dart';
import 'package:muslim360/features/prayer/presentation/widgets/next_prayer_progress.dart';
import 'package:muslim360/features/prayer/presentation/widgets/prayer_empty_widget.dart';
import 'package:muslim360/features/prayer/presentation/widgets/prayer_error_widget.dart';
import 'package:muslim360/features/prayer/presentation/widgets/prayer_loading_skeleton.dart';
import 'package:muslim360/features/prayer/presentation/widgets/prayer_times_list.dart';

class PrayerBody extends StatelessWidget {
  const PrayerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerCubit, PrayerState>(
      builder: (context, state) {
        if (state is PrayerLoading) {
          return const PrayerLoadingSkeleton();
        }

        if (state is PrayerError) {
          return PrayerErrorWidget(
            onRetry: () => context.read<PrayerCubit>().fetchTodayPrayer(),
          );
        }

        if (state is PrayerLoaded) {
          final today = state.todayPrayer;

          if (today.prayerTimesClean.isEmpty) {
            return const PrayerEmptyWidget();
          }

          return Column(
            children: [
              const SizedBox(height: 5),
              HijriGregorianDate(
                hijri: today.hijriFormatted,
                gregorian: today.gregorianFormatted,
              ),
              const SizedBox(height: 16),
              NextPrayerProgress(day: today),
              PrayerTimesList(day: today),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
