import 'package:flutter/widgets.dart';

class NavItemModel {
  final IconData icon;
  final String route;
  final String title;
  const NavItemModel({
    required this.icon,
    required this.route,
    required this.title,
  });
}
