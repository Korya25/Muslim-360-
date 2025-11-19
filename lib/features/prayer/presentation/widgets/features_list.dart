import 'package:flutter/material.dart';
import 'package:muslim360/core/theme/fonts/app_text_styles.dart';

class PrayerFeaturesSection extends StatelessWidget {
  const PrayerFeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        childAspectRatio: 0.5,
        physics: NeverScrollableScrollPhysics(),
        children: const [
          PrayerFeatureItem(
            title: 'كيفية الصلاة',
            imagePath: 'assets/image/more/salat.png',
          ),
          PrayerFeatureItem(
            title: 'المساجد القريبة',
            imagePath: 'assets/image/more/mosques.png',
          ),
          PrayerFeatureItem(
            title: 'القبلة',
            imagePath: 'assets/image/more/mosque (1).png',
          ),
          PrayerFeatureItem(
            title: 'تسابيح',
            imagePath: 'assets/image/more/tasbih.png',
          ),
        ],
      ),
    );
  }
}

class PrayerFeatureItem extends StatelessWidget {
  final String title;
  final String imagePath;

  const PrayerFeatureItem({
    super.key,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 55, child: Image.asset(imagePath, fit: BoxFit.cover)),
        const SizedBox(height: 4),
        Text(
          title,
          style: AppTextStyles.body.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
