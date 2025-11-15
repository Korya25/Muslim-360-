import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim360/core/theme/fonts/app_text_styles.dart';
import 'package:muslim360/core/theme/style/app_colors.dart';
import '../cubit/prayer_cubit.dart';
import '../cubit/prayer_state.dart';
import '../../domain/entities/prayer_calendar.dart';

class PrayerView extends StatefulWidget {
  const PrayerView({super.key});

  @override
  State<PrayerView> createState() => _PrayerViewState();
}

class _PrayerViewState extends State<PrayerView> {
  @override
  void initState() {
    super.initState();

    // LOCATION FAKE TEMPORARY
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      context.read<PrayerCubit>().loadPrayerCalendar(
        year: 2026,
        month: 2,
        latitude: 30.0444, // Cairo (Fake)
        longitude: 31.2357, // Cairo (Fake)
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: BlocBuilder<PrayerCubit, PrayerState>(
          builder: (context, state) {
            if (state is PrayerLoading || state is PrayerInitial) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryGreen),
              );
            } else if (state is PrayerError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: AppColors.white),
                ),
              );
            } else if (state is PrayerLoaded) {
              return _buildPrayerContent(state.calendar);
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _buildPrayerContent(PrayerCalendar calendar) {
    // اليوم الحالي (نجيب اليوم الأول كمثال)
    final today = calendar.data.first;
    final timings = today.timings;

    // تحويل أسماء الأيام والشهور للغة العربية إذا موجودة
    final weekdayAr =
        today.date.gregorian.weekday.ar ?? today.date.gregorian.weekday.en;
    final monthAr =
        today.date.gregorian.month.ar ?? today.date.gregorian.month.en;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // التاريخ
          Center(
            child: Column(
              children: [
                Text(
                  today.date.readable, // 18 Feb 2026
                  style: AppTextStyles.headlineLarge.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'اليوم: $weekdayAr, ${today.date.gregorian.day} $monthAr ${today.date.gregorian.year}',
                  style: AppTextStyles.body.copyWith(color: AppColors.textGrey),
                ),
                Text(
                  'هجري: ${today.date.hijri.day} ${today.date.hijri.month.ar ?? today.date.hijri.month.en} ${today.date.hijri.year}',
                  style: AppTextStyles.body.copyWith(color: AppColors.textGrey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // مواقيت الصلاة
          _buildPrayerTimeCard('الفجر', timings.fajr),
          _buildPrayerTimeCard('الشروق', timings.sunrise),
          _buildPrayerTimeCard('الظهر', timings.dhuhr),
          _buildPrayerTimeCard('العصر', timings.asr),
          _buildPrayerTimeCard('المغرب', timings.maghrib),
          _buildPrayerTimeCard('العشاء', timings.isha),
          const SizedBox(height: 24),
          // أوقات إضافية
          _buildPrayerTimeCard('الإمساك', timings.imsak),
          _buildPrayerTimeCard('منتصف الليل', timings.midnight),
        ],
      ),
    );
  }

  Widget _buildPrayerTimeCard(String name, String time) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.bottomNavBarBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.bottomNavBarBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: AppTextStyles.body.copyWith(color: AppColors.textWhite),
          ),
          Text(
            time,
            style: AppTextStyles.body.copyWith(color: AppColors.primaryGreen),
          ),
        ],
      ),
    );
  }
}
