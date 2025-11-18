import 'package:flutter/material.dart';
import 'package:muslim360/core/theme/fonts/app_text_styles.dart';

class HijriGregorianDate extends StatelessWidget {
  const HijriGregorianDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 2,
      children: [
        Text('14 ذو الحجة 1445 هـ', style: AppTextStyles.body18BoldWhite),
        Text('الجمعة, 28 يونيو 2025', style: AppTextStyles.body14W800Grey),
      ],
    );
  }
}
