import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim360/features/prayer/presentation/cubit/prayer_cubit.dart';
import 'package:muslim360/features/prayer/presentation/cubit/prayer_state.dart';
import 'package:muslim360/features/prayer/presentation/widgets/hijri_gregorian_date.dart';
import 'package:muslim360/features/prayer/presentation/widgets/next_prayer_progress.dart';
import 'package:muslim360/features/prayer/presentation/widgets/prayer_times_list.dart';

class PrayerBody extends StatelessWidget {
  const PrayerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerCubit, PrayerState>(
      builder: (context, state) {
        if (state is PrayerLoading) {
          return SizedBox(
            height: 300,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is PrayerLoaded) {
          final todayPrayer = state.todayPrayer;
          return Column(
            children: [
              const SizedBox(height: 5),
              Center(
                child: HijriGregorianDate(
                  hijri: todayPrayer.hijriFormatted,
                  gregorian: todayPrayer.gregorianFormatted,
                ),
              ),
              const SizedBox(height: 16),
              Center(child: NextPrayerProgress(day: todayPrayer)),
              PrayerTimesList(day: todayPrayer),
            ],
          );
        } else if (state is PrayerError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('تحقق من الاتصال بالانترنت'),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
