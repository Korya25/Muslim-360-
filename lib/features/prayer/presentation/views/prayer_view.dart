import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/prayer_cubit.dart';
import '../cubit/prayer_state.dart';
import '../../domain/entities/prayer_day.dart';

class PrayerView extends StatefulWidget {
  const PrayerView({super.key});

  @override
  State<PrayerView> createState() => _PrayerViewState();
}

class _PrayerViewState extends State<PrayerView> {
  @override
  void initState() {
    super.initState();
    // Load prayer times when view is first opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadPrayerTimes(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prayer Times')),
      body: BlocBuilder<PrayerCubit, PrayerState>(
        builder: (context, state) {
          if (state is PrayerLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PrayerError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _loadPrayerTimes(context);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is PrayerLoaded) {
            final currentDay = _getCurrentDay(state.calendar.data);

            if (currentDay == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Current day not found in calendar'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _loadPrayerTimes(context);
                      },
                      child: const Text('Reload'),
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date Section
                      _buildDateSection(currentDay),
                      const Divider(height: 32),

                      // Prayer Timings Section
                      _buildSectionTitle('Prayer Timings'),
                      const SizedBox(height: 16),
                      _buildTimingRow('Imsak', currentDay.timings.imsak),
                      _buildTimingRow('Fajr', currentDay.timings.fajr),
                      _buildTimingRow('Sunrise', currentDay.timings.sunrise),
                      _buildTimingRow('Dhuhr', currentDay.timings.dhuhr),
                      _buildTimingRow('Asr', currentDay.timings.asr),
                      _buildTimingRow('Sunset', currentDay.timings.sunset),
                      _buildTimingRow('Maghrib', currentDay.timings.maghrib),
                      _buildTimingRow('Isha', currentDay.timings.isha),
                      const Divider(height: 32),

                      // Additional Timings Section
                      _buildSectionTitle('Additional Timings'),
                      const SizedBox(height: 16),
                      _buildTimingRow('Midnight', currentDay.timings.midnight),
                      _buildTimingRow(
                        'First Third',
                        currentDay.timings.firstthird,
                      ),
                      _buildTimingRow(
                        'Last Third',
                        currentDay.timings.lastthird,
                      ),
                      const Divider(height: 32),

                      // Meta Information Section
                      _buildSectionTitle('Location & Method'),
                      const SizedBox(height: 16),
                      _buildInfoRow('Timezone', currentDay.meta.timezone),
                      _buildInfoRow('Method', currentDay.meta.method.name),
                      _buildInfoRow(
                        'Latitude',
                        currentDay.meta.latitude.toStringAsFixed(5),
                      ),
                      _buildInfoRow(
                        'Longitude',
                        currentDay.meta.longitude.toStringAsFixed(5),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return Center(
            child: ElevatedButton(
              onPressed: () {
                _loadPrayerTimes(context);
              },
              child: const Text('Load Prayer Times'),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateSection(PrayerDay day) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          day.date.readable,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          day.date.gregorian.weekday.en,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildDateCard(
                'Gregorian',
                day.date.gregorian.date,
                day.date.gregorian.month.en,
                day.date.gregorian.year,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildDateCard(
                'Hijri',
                day.date.hijri.date,
                day.date.hijri.month.en,
                day.date.hijri.year,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateCard(String title, String date, String month, String year) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            '$month $year',
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTimingRow(String name, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  PrayerDay? _getCurrentDay(List<PrayerDay> days) {
    final now = DateTime.now();
    final currentDate =
        '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';

    try {
      return days.firstWhere((day) => day.date.gregorian.date == currentDate);
    } catch (e) {
      // If exact match not found, try to find by readable date
      final readableDate =
          '${now.day.toString().padLeft(2, '0')} ${_getMonthName(now.month)} ${now.year}';
      try {
        return days.firstWhere((day) => day.date.readable == readableDate);
      } catch (e) {
        // Return first day if current day not found
        return days.isNotEmpty ? days.first : null;
      }
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  void _loadPrayerTimes(BuildContext context) {
    // Default coordinates (Cairo, Egypt)
    // In a real app, you would get these from location services
    context.read<PrayerCubit>().loadPrayerCalendar(
      year: DateTime.now().year,
      month: DateTime.now().month,
      latitude: 30.96713,
      longitude: 31.02648,
    );
  }
}
