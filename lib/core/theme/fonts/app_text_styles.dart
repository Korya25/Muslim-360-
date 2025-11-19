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

  static const TextStyle amiri = TextStyle(
    fontFamily: AppFontsFamily.amiri,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle head30W700Primary = headlineLarge.copyWith(
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    fontSize: 30,
    height: 0.7,
  );

  static final TextStyle amiri18W600White200 = amiri.copyWith(
    fontSize: 18,
    height: 1.3,
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite.withAlpha(200),
  );

  static final TextStyle amiri16W600White180 = amiri.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite.withAlpha(180),
  );
  static final TextStyle body24W700White = body.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 0.7,
    color: AppColors.textWhite,
  );
  static final TextStyle body13BoldWhite = body.copyWith(
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
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

  static final TextStyle quran18W600White = body.copyWith(
    color: AppColors.textWhite,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
}
