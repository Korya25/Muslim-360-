// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      decoration: BoxDecoration(color: AppColors.bottomNavBarBackground),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: NavItems.items.map((item) {
          final isSelected = currentRoute == item.route;
          return Expanded(
            child: InkWell(
              onTap: () {
                if (!isSelected) context.go(item.route);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      isSelected ? item.iconActive : item.icon,
                      width: 22,
                      color: isSelected
                          ? AppColors.primaryGreen
                          : AppColors.textGrey,
                    ),
                    Text(
                      item.title.truncate(8),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.quran.copyWith(
                        fontSize: 16,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: isSelected
                            ? AppColors.primaryGreen
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
