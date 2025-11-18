import 'package:flutter/material.dart';
import 'package:muslim360/core/theme/fonts/app_fonts_family.dart';
import 'package:muslim360/core/theme/style/app_colors.dart';

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

  static final TextStyle quran24W100White = quran.copyWith(
    color: AppColors.textWhite,
    fontSize: 25,
    fontWeight: FontWeight.w100,
  );

  static final TextStyle body24BoldWhite = body.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
  );

  static final TextStyle body16W800Grey = body.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: AppColors.textGrey,
  );

  static final TextStyle body30BoldWhite = body.copyWith(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
    height: 1,
  );

  static final TextStyle headline18W900Grey = headlineLarge.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w900,
    color: AppColors.textGrey,
  );

  static final TextStyle headline30W900Primary = headlineLarge.copyWith(
    fontSize: 30,
    fontWeight: FontWeight.w900,
    color: AppColors.textPrimary,
  );

  static final TextStyle body14W800Grey = body.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    color: AppColors.textGrey,
  );
}
