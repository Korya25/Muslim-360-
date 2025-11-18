import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muslim360/core/constants/svgs_icon.dart';
import 'package:muslim360/core/theme/fonts/app_text_styles.dart';
import 'package:muslim360/core/theme/style/app_colors.dart';

class PrayerTimesScreen extends StatelessWidget {
  PrayerTimesScreen({super.key});

  /// بيانات جاهزة داخل الكود
  final Map<String, dynamic> prayerData = {
    "timings": {
      "Fajr": "04:30 (EET)",
      "Sunrise": "05:55 (EET)",
      "Dhuhr": "12:45 (EET)",
      "Asr": "16:15 (EET)",
      "Sunset": "17:46 (EET)",
      "Maghrib": "19:05 (EET)",
      "Isha": "20:30 (EET)",
    },
  };

  /// بيانات ثابتة للصلاة القادمة
  final Map<String, dynamic> nextPrayer = {
    "name": "Dhuhr",
    "time": "12:45",
    "progress": 0.45,
    "remainingHours": 1,
    "remainingMinutes": 23,
  };

  /// ترجمة أسماء الصلوات
  String _translateToArabic(String prayer) {
    switch (prayer) {
      case "Fajr":
        return "الفجر";
      case "Dhuhr":
        return "الظهر";
      case "Asr":
        return "العصر";
      case "Maghrib":
        return "المغرب";
      case "Isha":
        return "العشاء";
      default:
        return prayer;
    }
  }

  String _extractTime(String full) {
    return full.split(" ").first;
  }

  @override
  Widget build(BuildContext context) {
    final timings = prayerData["timings"];

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              // Prayer  القادمة
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Progress Ring
                    SizedBox(
                      width: 220,
                      height: 220,
                      child: CircularProgressIndicator(
                        value: nextPrayer['progress'] as double,
                        strokeWidth: 4,
                        backgroundColor: AppColors.secondaryBackground,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primaryGreen,
                        ),
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    // Inner Circle Content
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _translateToArabic(nextPrayer['name'] as String),
                          style: AppTextStyles.quran.copyWith(
                            color: AppColors.textPrimary,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          nextPrayer['time'] as String,
                          style: AppTextStyles.quran.copyWith(
                            color: AppColors.textWhite,
                            fontSize: 35,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${nextPrayer['remainingHours']}h ${nextPrayer['remainingMinutes']}m',
                          style: AppTextStyles.quran.copyWith(
                            color: AppColors.textWhite,
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text(
                "مواقيت الصلاة",
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              _buildPrayerRow(
                title: _translateToArabic("Fajr"),
                time: _extractTime(timings["Fajr"]),
              ),
              const SizedBox(height: 16),

              _buildPrayerRow(
                title: _translateToArabic("Dhuhr"),
                time: _extractTime(timings["Dhuhr"]),
              ),
              const SizedBox(height: 16),

              _buildPrayerRow(
                title: _translateToArabic("Asr"),
                time: _extractTime(timings["Asr"]),
              ),
              const SizedBox(height: 16),

              _buildPrayerRow(
                title: _translateToArabic("Maghrib"),
                time: _extractTime(timings["Maghrib"]),
              ),
              const SizedBox(height: 16),

              _buildPrayerRow(
                title: _translateToArabic("Isha"),
                time: _extractTime(timings["Isha"]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrayerRow({required String title, required String time}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // اسم الصلاة
        Text(
          title,
          style: AppTextStyles.quran.copyWith(
            color: AppColors.textWhite,
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),

        // الوقت + الأيقونة
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                time,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textWhite,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ],
    );
  }
}
