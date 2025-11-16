import 'package:muslim360/core/constants/svgs_icon.dart';
import 'package:muslim360/core/presentation/widgets/bottom_nav/nav_item_model.dart';
import 'package:muslim360/core/routing/app_routes.dart';

class NavItems {
  static final List<NavItemModel> items = [
    NavItemModel(
      icon: SvgsIcon.houseChimney,
      route: AppRoutes.home,
      title: 'الرئيسية',
    ),
    const NavItemModel(
      icon: SvgsIcon.mosque,
      route: AppRoutes.prayer,
      title: 'الصلاة',
    ),
    const NavItemModel(
      icon: SvgsIcon.bookQuran,
      route: AppRoutes.quran,
      title: 'القرآن',
    ),
    NavItemModel(
      icon: SvgsIcon.prayingHands,
      route: AppRoutes.azkar,
      title: 'الأذكار',
    ),
    const NavItemModel(
      icon: SvgsIcon.settings,
      route: AppRoutes.more,
      title: 'الضبط',
    ),
  ];
}
