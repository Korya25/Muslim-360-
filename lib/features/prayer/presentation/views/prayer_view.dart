import 'package:flutter/material.dart';
import 'package:muslim360/features/prayer/presentation/data/prayer_data.dart';
import 'package:muslim360/features/prayer/presentation/widgets/features_list.dart';
import 'package:muslim360/features/prayer/presentation/widgets/hijri_gregorian_date.dart';
import 'package:muslim360/features/prayer/presentation/widgets/next_prayer_progress.dart';
import 'package:muslim360/features/prayer/presentation/widgets/prayer_times_list.dart';

class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: HijriGregorianDate()),

              const SizedBox(height: 16),
              Center(
                child: NextPrayerProgress(
                  progress: 0.1,
                  prayerName: 'العصر',
                  prayerTime: '3:20م',
                  remainingTime: '1:30:15',
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: PrayerTimesList(
                  prayerTimes: fakePrayerTimes,
                  currentPrayerKey: 'dhuhr',
                ),
              ),

              const SizedBox(height: 22),

              PrayerFeaturesSection(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
