import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim360/features/prayer/presentation/cubit/prayer_cubit.dart';
import 'package:muslim360/features/prayer/presentation/cubit/prayer_state.dart';
import 'package:muslim360/features/prayer/presentation/widgets/features_list.dart';
import 'package:muslim360/features/prayer/presentation/widgets/hijri_gregorian_date.dart';
import 'package:muslim360/features/prayer/presentation/widgets/next_prayer_progress.dart';
import 'package:muslim360/features/prayer/presentation/widgets/prayer_times_list.dart';

class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PrayerCubit, PrayerState>(
        builder: (context, state) {
          if (state is PrayerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PrayerLoaded) {
            final todayPrayer = state.todayPrayer;

            return SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2),
                    Center(
                      child: HijriGregorianDate(
                        hijri: todayPrayer.hijriFormatted,
                        gregorian: todayPrayer.gregorianFormatted,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(child: NextPrayerProgress(day: todayPrayer)),
                    PrayerTimesList(day: todayPrayer),
                    const SizedBox(height: 22),
                    const PrayerFeaturesSection(),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          } else if (state is PrayerError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
