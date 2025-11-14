// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:muslim360/core/extension/string_extension.dart';
import 'package:muslim360/core/theme/style/app_colors.dart';
import 'package:muslim360/core/theme/fonts/app_text_styles.dart';
import 'nav_items.dart';

class CustomNavBar extends StatelessWidget {
  final String currentRoute;

  const CustomNavBar({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      decoration: BoxDecoration(color: AppColors.bottomNavBarBackground),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: NavItems.items.map((item) {
          final isSelected = currentRoute == item.route;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                if (!isSelected) context.go(item.route);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Column(
                  spacing: 8,
                  children: [
                    Icon(
                      item.icon,
                      size: 26,
                      color: isSelected
                          ? AppColors.textWhite
                          : AppColors.textGrey,
                    ),
                    Text(
                      item.title.truncate(8),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 12,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: isSelected
                            ? AppColors.textWhite
                            : AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
