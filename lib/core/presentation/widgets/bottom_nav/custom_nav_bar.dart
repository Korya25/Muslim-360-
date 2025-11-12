import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:muslim360/core/theme/style/app_colors.dart';
import 'nav_item_model.dart';
import 'nav_items.dart';

class CustomNavBar extends StatelessWidget {
  final String currentRoute;

  const CustomNavBar({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.bottomNavBarBackground,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: AppColors.bottomNavBarBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.bottomNavBarShadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: NavItems.items
            .map(
              (item) => _NavBarItem(
                item: item,
                isSelected: currentRoute == item.route,
                onTap: () => context.go(item.route),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final NavItemModel item;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.bottomNavBarSelected
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          item.icon,
          size: 26,
          color: isSelected
              ? AppColors.bottomNavBarSelectedIcon
              : AppColors.bottomNavBarUnselectedIcon,
        ),
      ),
    );
  }
}
