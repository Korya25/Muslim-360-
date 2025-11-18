import 'package:flutter/material.dart';

import 'package:muslim360/features/prayer/presentation/widgets/hijri_gregorian_date.dart';
import 'package:muslim360/features/prayer/presentation/widgets/next_prayer_progress.dart';

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
              spacing: 30,
              children: [
                Center(child: HijriGregorianDate()),

                NextPrayerProgress(
                  progress: 0.6,
                  prayerName: 'العصر',
                  prayerTime: '3:20 م',
                  remainingTime: '1:30:15',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
