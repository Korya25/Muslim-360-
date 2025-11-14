import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:muslim360/core/constants/app_constants.dart';

import 'core/di/service_locator.dart';
import 'core/routing/app_router.dart';
import 'core/theme/style/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  runApp(
    DevicePreview(builder: (context) => MuslimApp()),
    // MuslimApp(),
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
