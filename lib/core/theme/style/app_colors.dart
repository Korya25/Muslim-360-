// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();
  // Scaffold background
  static const scaffoldBackground = Color(0xFF0F0F0F);

  // Common Colors
  static const primaryGreen = Color(0xFF35A306);
  static const white = Color(0xFFFFFFFF);
  static const grey = Colors.grey;

  // Text
  static const textWhite = white;
  static const textGrey = grey;

  // Icons
  static const iconWhite = white;
  static const iconGrey = grey;

  // Nav Bar
  static const bottomNavBarBackground = Color.fromARGB(255, 21, 21, 21);
  static const bottomNavBarSelected = primaryGreen;
  static const bottomNavBarSelectedIcon = iconWhite;
  static const bottomNavBarUnselectedIcon = grey;
  static Color bottomNavBarBorder = grey.withOpacity(0.1);
  static Color bottomNavBarShadow = primaryGreen.withOpacity(0.2);
}
