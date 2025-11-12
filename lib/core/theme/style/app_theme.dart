import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      primaryColor: AppColors.bottomNavBarSelected,
      iconTheme: const IconThemeData(
        color: AppColors.bottomNavBarUnselectedIcon,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.bottomNavBarBackground,
        selectedItemColor: AppColors.bottomNavBarSelectedIcon,
        unselectedItemColor: AppColors.bottomNavBarUnselectedIcon,
      ),
    );
  }
}
