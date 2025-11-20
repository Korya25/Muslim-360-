import 'package:flutter/material.dart';
import 'package:muslim360/core/theme/fonts/app_text_styles.dart';

class HijriGregorianDate extends StatelessWidget {
  const HijriGregorianDate({
    super.key,
    required this.gregorian,
    required this.hijri,
  });

  final String gregorian;
  final String hijri;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          hijri,
          style: AppTextStyles.body13BoldWhite.copyWith(fontSize: 16),
        ),
        Text(
          gregorian,
          style: AppTextStyles.body14W800Grey.copyWith(fontSize: 12),
        ),
      ],
    );
  }
}
