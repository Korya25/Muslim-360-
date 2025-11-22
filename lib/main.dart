import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim360/core/constants/app_constants.dart';
import 'package:muslim360/core/services/location/location_service.dart';
import 'package:muslim360/core/utils/bloc_observer.dart';
import 'package:muslim360/features/prayer/data/repo/prayer_repository.dart';
import 'package:muslim360/features/prayer/presentation/cubit/prayer_cubit.dart';
import 'core/di/service_locator.dart';
import 'core/routing/app_router.dart';
import 'core/theme/style/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await setupLocator();

  runApp(
    //DevicePreview(builder: (context) => MuslimApp()),
    MuslimApp(),
  );
}

class MuslimApp extends StatelessWidget {
  const MuslimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PrayerCubit(
            repository: sl<PrayerRepository>(),
            locationService: sl<LocationService>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: AppConstants.appName,
        theme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        routerConfig: AppRouter.router,
        locale: const Locale('ar', 'EG'),
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          );
        },
      ),
    );
  }
}
