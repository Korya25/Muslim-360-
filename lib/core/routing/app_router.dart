import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:muslim360/core/di/service_locator.dart';
import 'package:muslim360/core/presentation/view/main_view.dart';
import 'package:muslim360/core/routing/app_routes.dart';
import 'package:muslim360/core/routing/app_transitions.dart';
import 'package:muslim360/features/Splash/presentation/views/splash_view.dart';
import 'package:muslim360/features/prayer/data/repo/prayer_repository.dart';
import 'package:muslim360/features/prayer/presentation/cubit/prayer_cubit.dart';
import 'package:muslim360/features/prayer/presentation/views/prayer_view.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: AppRoutes.splash,
        pageBuilder: (context, state) => AppTransitions.noTransition(
          context: context,
          state: state,
          child: SplashView(),
        ),
      ),
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
              child: BlocProvider(
                create: (_) => PrayerCubit(
                  repository: sl<PrayerRepository>(),
                  latitude: 30.0444,
                  longitude: 31.2357,
                )..fetchTodayPrayer(),

                child: PrayerTimesScreen(),
              ),
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
        ],
      ),
    ],
  );
}
