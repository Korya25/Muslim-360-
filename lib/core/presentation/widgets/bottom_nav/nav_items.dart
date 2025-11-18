import 'package:muslim360/core/presentation/widgets/bottom_nav/nav_item_model.dart';
import 'package:muslim360/core/routing/app_routes.dart';

class NavItems {
  static final List<NavItemModel> items = [
    NavItemModel(
      icon: 'assets/svgs/navbar/house.svg',
      iconActive: 'assets/svgs/navbar/house1.svg',
      route: AppRoutes.home,
      title: 'الرئيسية',
    ),
    const NavItemModel(
      icon: 'assets/svgs/navbar/mosque.svg',
      iconActive: 'assets/svgs/navbar/mosque1.svg',
      route: AppRoutes.prayer,
      title: 'الصلاة',
    ),
    const NavItemModel(
      icon: 'assets/svgs/navbar/quran.svg',
      iconActive: 'assets/svgs/navbar/quran1.svg',
      route: AppRoutes.quran,
      title: 'القرآن',
    ),
  ];
}
