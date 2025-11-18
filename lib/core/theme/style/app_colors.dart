// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();
  static const scaffoldBackground = Color(0xFF0F0F0F);
  static const secondaryBackground = Color.fromARGB(255, 25, 25, 25);
  static const primaryGreen = Color(0xFF35A306);
  static const white = Color(0xFFFFFFFF);
  static const grey = Colors.grey;
  static const textWhite = white;
  static const textGrey = grey;
  static const textPrimary = primaryGreen;
  static const iconPrimary = primaryGreen;
  static const iconWhite = white;
  static const iconGrey = grey;
  static const bottomNavBarBackground = secondaryBackground;
  static const bottomNavBarSelected = primaryGreen;
  static const bottomNavBarSelectedIcon = iconWhite;
  static const bottomNavBarUnselectedIcon = grey;
  static Color bottomNavBarBorder = grey.withOpacity(0.1);
  static Color bottomNavBarShadow = primaryGreen.withOpacity(0.2);
}
