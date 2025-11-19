import 'package:flutter/material.dart';

import 'package:muslim360/features/prayer/presentation/data/prayer_data.dart';
import 'package:muslim360/features/prayer/presentation/widgets/hijri_gregorian_date.dart';
import 'package:muslim360/features/prayer/presentation/widgets/next_prayer_progress.dart';
import 'package:muslim360/features/prayer/presentation/widgets/prayer_times_list.dart';

class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SafeArea(
            child: Column(
              children: [
                Center(child: HijriGregorianDate()),

                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: NextPrayerProgress(
                    progress: 0.1,
                    prayerName: 'العصر',
                    prayerTime: '3:20م',
                    remainingTime: '1:30:15',
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: PrayerTimesList(
                    prayerTimes: fakePrayerTimes,
                    currentPrayerKey: 'dhuhr',
                  ),
                ),

                SizedBox(height: 300),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
