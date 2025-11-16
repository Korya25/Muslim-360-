// ignore_for_file: unused_element, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:muslim360/core/theme/fonts/app_fonts_family.dart';
import 'package:muslim360/core/theme/style/app_colors.dart';

class PrayerTimesScreen extends StatelessWidget {
  final Map<String, dynamic> prayerData = {
    "timings": {
      "Fajr": "05:06 (EET)",
      "Sunrise": "06:34 (EET)",
      "Dhuhr": "12:10 (EET)",
      "Asr": "15:20 (EET)",
      "Sunset": "17:46 (EET)",
      "Maghrib": "17:46 (EET)",
      "Isha": "19:04 (EET)",
      "Imsak": "04:56 (EET)",
      "Midnight": "00:10 (EET)",
      "Firstthird": "22:02 (EET)",
      "Lastthird": "02:18 (EET)",
    },
    "date": {
      "readable": "18 Feb 2026",
      "timestamp": "1771398061",
      "gregorian": {
        "date": "18-02-2026",
        "format": "DD-MM-YYYY",
        "day": "18",
        "weekday": {"en": "Wednesday"},
        "month": {"number": 2, "en": "February"},
        "year": "2026",
        "designation": {"abbreviated": "AD", "expanded": "Anno Domini"},
        "lunarSighting": false,
      },
      "hijri": {
        "date": "01-09-1447",
        "format": "DD-MM-YYYY",
        "day": "1",
        "weekday": {"en": "Al Arba'a", "ar": "الاربعاء"},
        "month": {"number": 9, "en": "Ramaḍān", "ar": "رَمَضان", "days": 30},
        "year": "1447",
        "designation": {"abbreviated": "AH", "expanded": "Anno Hegirae"},
        "holidays": ["1st Day of Ramadan"],
        "adjustedHolidays": [],
        "method": "HJCoSA",
      },
    },
    "meta": {
      "latitude": 30.96713,
      "longitude": 31.02648,
      "timezone": "Africa/Cairo",
      "method": {
        "id": 5,
        "name": "Egyptian General Authority of Survey",
        "params": {"Fajr": 19.5, "Isha": 17.5},
        "location": {"latitude": 30.0444196, "longitude": 31.2357116},
      },
      "latitudeAdjustmentMethod": "ANGLE_BASED",
      "midnightMode": "STANDARD",
      "school": "STANDARD",
      "offset": {
        "Imsak": 0,
        "Fajr": 0,
        "Sunrise": 0,
        "Dhuhr": 0,
        "Asr": 0,
        "Maghrib": 0,
        "Sunset": 0,
        "Isha": 0,
        "Midnight": 0,
      },
    },
  };

  PrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              /*  _buildHeaderSection(),
              const SizedBox(height: 24),

              // Date Cards
              _buildDateCards(),
              const SizedBox(height: 24),

              // Main Prayer Times
              _buildMainPrayerTimes(),
              const SizedBox(height: 24),

              // Additional Times
              _buildAdditionalTimes(),
              const SizedBox(height: 24),

              // Location Info
              _buildLocationInfo(),*/
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'أوقات الصلاة',
          style: TextStyle(
            fontFamily: AppFontsFamily.reemKufi,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.textWhite,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          prayerData['date']['readable'],
          style: TextStyle(
            fontFamily: AppFontsFamily.cairo,
            fontSize: 16,
            color: AppColors.textGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildDateCards() {
    return Row(
      children: [
        Expanded(
          child: _buildDateCard(
            'الهجري',
            prayerData['date']['hijri']['date'],
            prayerData['date']['hijri']['month']['ar'],
            prayerData['date']['hijri']['holidays'].isNotEmpty
                ? prayerData['date']['hijri']['holidays'][0]
                : null,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildDateCard(
            'الميلادي',
            prayerData['date']['gregorian']['date'],
            prayerData['date']['gregorian']['month']['en'],
            null,
          ),
        ),
      ],
    );
  }

  Widget _buildDateCard(
    String title,
    String date,
    String month,
    String? holiday,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bottomNavBarBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.bottomNavBarBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: AppFontsFamily.cairo,
              fontSize: 14,
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            date,
            style: TextStyle(
              fontFamily: AppFontsFamily.reemKufi,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textWhite,
            ),
          ),
          Text(
            month,
            style: TextStyle(
              fontFamily: AppFontsFamily.cairo,
              fontSize: 14,
              color: AppColors.textGrey,
            ),
          ),
          if (holiday != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryGreen.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                holiday,
                style: TextStyle(
                  fontFamily: AppFontsFamily.cairo,
                  fontSize: 12,
                  color: AppColors.primaryGreen,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMainPrayerTimes() {
    final mainPrayers = ['Fajr', 'Sunrise', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'أوقات الصلاة الرئيسية',
          style: TextStyle(
            fontFamily: AppFontsFamily.reemKufi,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textWhite,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.5,
          ),
          itemCount: mainPrayers.length,
          itemBuilder: (context, index) {
            final prayer = mainPrayers[index];
            final time = prayerData['timings'][prayer];
            return _buildPrayerTimeCard(prayer, time, isMain: true);
          },
        ),
      ],
    );
  }

  Widget _buildAdditionalTimes() {
    final additionalPrayers = ['Imsak', 'Midnight', 'Firstthird', 'Lastthird'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'أوقات إضافية',
          style: TextStyle(
            fontFamily: AppFontsFamily.reemKufi,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textWhite,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: additionalPrayers.map((prayer) {
            final time = prayerData['timings'][prayer];
            return _buildPrayerTimeCard(prayer, time, isMain: false);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPrayerTimeCard(
    String prayerName,
    String time, {
    bool isMain = false,
  }) {
    final prayerNames = {
      'Fajr': 'الفجر',
      'Sunrise': 'الشروق',
      'Dhuhr': 'الظهر',
      'Asr': 'العصر',
      'Maghrib': 'المغرب',
      'Isha': 'العشاء',
      'Imsak': 'الإمساك',
      'Midnight': 'منتصف الليل',
      'Firstthird': 'الثلث الأول',
      'Lastthird': 'الثلث الأخير',
      'Sunset': 'الغروب',
    };

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isMain
            ? AppColors.bottomNavBarBackground
            : AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isMain
              ? AppColors.primaryGreen.withOpacity(0.3)
              : AppColors.bottomNavBarBorder,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                prayerNames[prayerName] ?? prayerName,
                style: TextStyle(
                  fontFamily: AppFontsFamily.cairo,
                  fontSize: isMain ? 16 : 14,
                  fontWeight: isMain ? FontWeight.w600 : FontWeight.w400,
                  color: AppColors.textWhite,
                ),
              ),
              if (isMain) ...[
                const SizedBox(height: 4),
                Text(
                  prayerName,
                  style: TextStyle(
                    fontFamily: AppFontsFamily.cairo,
                    fontSize: 12,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ],
          ),
          Text(
            time.split(' ')[0],
            style: TextStyle(
              fontFamily: AppFontsFamily.reemKufi,
              fontSize: isMain ? 18 : 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryGreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bottomNavBarBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.bottomNavBarBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'معلومات الموقع',
            style: TextStyle(
              fontFamily: AppFontsFamily.reemKufi,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textWhite,
            ),
          ),
          const SizedBox(height: 12),
          _buildInfoRow('الموقع', prayerData['meta']['timezone']),
          _buildInfoRow('خط العرض', '${prayerData['meta']['latitude']}°'),
          _buildInfoRow('خط الطول', '${prayerData['meta']['longitude']}°'),
          _buildInfoRow('طريقة الحساب', prayerData['meta']['method']['name']),
          _buildInfoRow('المدرسة', prayerData['meta']['school']),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: AppFontsFamily.cairo,
              fontSize: 14,
              color: AppColors.textGrey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: AppFontsFamily.cairo,
              fontSize: 14,
              color: AppColors.textWhite,
            ),
          ),
        ],
      ),
    );
  }
}
