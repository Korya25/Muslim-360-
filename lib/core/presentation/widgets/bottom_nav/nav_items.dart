import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:muslim360/core/presentation/widgets/bottom_nav/nav_item_model.dart';
import 'package:muslim360/core/routing/app_routes.dart';

class NavItems {
  static final List<NavItemModel> items = [
    NavItemModel(icon: Icons.home, route: AppRoutes.home),
    const NavItemModel(
      icon: FlutterIslamicIcons.solidPrayingPerson,
      route: AppRoutes.prayer,
    ),
    const NavItemModel(
      icon: FlutterIslamicIcons.solidQuran,
      route: AppRoutes.quran,
    ),
    NavItemModel(icon: FlutterIslamicIcons.solidPrayer, route: AppRoutes.azkar),
    const NavItemModel(icon: Icons.more_horiz, route: AppRoutes.more),
  ];
}
