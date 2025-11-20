import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim360/core/constants/app_constants.dart';
import 'package:muslim360/core/utils/bloc_observer.dart';
import 'core/di/service_locator.dart';
import 'core/routing/app_router.dart';
import 'core/theme/style/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await setupLocator();
  /* PrayerRemoteDataSourceImpl(dio: Dio()).getPrayerMonth(
    year: 2025,
    month: 11,
    latitude: 30.0444,
    longitude: 31.2357,
  );*/
  runApp(
    //DevicePreview(builder: (context) => MuslimApp()),
    MuslimApp(),
  );
}

class MuslimApp extends StatelessWidget {
  const MuslimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      routerConfig: AppRouter.router,
      locale: const Locale('ar', 'EG'),
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
    );
  }
}
