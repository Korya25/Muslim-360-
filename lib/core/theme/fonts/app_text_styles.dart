import 'package:flutter/material.dart';
import 'package:muslim360/core/theme/fonts/app_fonts_family.dart';

class AppTextStyles {
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: AppFontsFamily.reemKufi,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );

  static const TextStyle body = TextStyle(
    fontFamily: AppFontsFamily.cairo,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle quran = TextStyle(
    fontFamily: AppFontsFamily.amiri,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
}
