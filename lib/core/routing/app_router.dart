import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:muslim360/core/presentation/view/main_view.dart';
import 'package:muslim360/core/routing/app_routes.dart';
import 'package:muslim360/core/routing/app_transitions.dart';
import 'package:muslim360/features/prayer/presentation/views/prayer_view.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.prayer,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MainView(state: state, child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: AppRoutes.home,
            pageBuilder: (context, state) => AppTransitions.noTransition(
              context: context,
              state: state,
              child: Scaffold(),
            ),
          ),
          GoRoute(
            path: AppRoutes.prayer,
            name: AppRoutes.prayer,
            pageBuilder: (context, state) => AppTransitions.slideFromRight(
              context: context,
              state: state,
              child: const PrayerView(),
            ),
          ),
          GoRoute(
            path: AppRoutes.quran,
            name: AppRoutes.quran,
            pageBuilder: (context, state) => AppTransitions.fade(
              context: context,
              state: state,
              child: const Scaffold(),
            ),
          ),
          GoRoute(
            path: AppRoutes.azkar,
            name: AppRoutes.azkar,
            pageBuilder: (context, state) => AppTransitions.slideFromBottom(
              context: context,
              state: state,
              child: const Scaffold(),
            ),
          ),
          GoRoute(
            path: AppRoutes.more,
            name: AppRoutes.more,
            pageBuilder: (context, state) => AppTransitions.fadeScale(
              context: context,
              state: state,
              child: const Scaffold(),
            ),
          ),
        ],
      ),
    ],
  );
}
