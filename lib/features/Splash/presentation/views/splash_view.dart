import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:muslim360/core/routing/app_routes.dart';
import 'package:muslim360/core/services/location/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:muslim360/core/services/sharedpref/pref_keys.dart';
import 'package:muslim360/core/services/sharedpref/shared_pref.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleLocationFlow();
    });
  }

  Future<void> _handleLocationFlow() async {
    final prefs = SharedPref().getPreferenceInstance();
    final latitude = prefs.getDouble(PrefKeys.latitudeKey);
    final longitude = prefs.getDouble(PrefKeys.longitudeKey);

    // لو الموقع محفوظ مسبقًا
    if (latitude != null && longitude != null) {
      if (mounted) context.goNamed(AppRoutes.prayer);
      return;
    }

    // التحقق من خدمة الموقع
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // فتح إعدادات الموقع فقط إذا الخدمة غير مفعلة
      await Geolocator.openLocationSettings();
      Future.delayed(const Duration(seconds: 1), _handleLocationFlow);
      return;
    }

    // طلب الإذن بعد التأكد من أن الخدمة مفعلة
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      await _goToPrayer();
    } else {
      _showLocationDialog(
        "يجب تفعيل الإذن للوصول للموقع لتتمكن من استخدام التطبيق",
      );
    }
  }

  /// الانتقال لصفحة الصلاة وحفظ الموقع
  Future<void> _goToPrayer() async {
    try {
      final position = await _locationService.getCurrentLocation();
      if (position != null) {
        final prefs = SharedPref().getPreferenceInstance();
        await prefs.setDouble(PrefKeys.latitudeKey, position.latitude);
        await prefs.setDouble(PrefKeys.longitudeKey, position.longitude);

        if (mounted) context.goNamed(AppRoutes.prayer);
      } else {
        _showLocationDialog("تعذر الحصول على الموقع الحالي");
      }
    } catch (e) {
      _showLocationDialog(e.toString());
    }
  }

  /// عرض رسالة للمستخدم في حال رفض الإذن أو عدم توفر الموقع
  void _showLocationDialog(String? message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('الموقع مطلوب'),
        content: Text(
          message ??
              'يجب تفعيل خدمة الموقع وإعطاء الإذن لتتمكن من استخدام التطبيق.',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _handleLocationFlow();
            },
            child: const Text('حاول مرة أخرى'),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(),
            child: const Text('اغلاق التطبيق'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
