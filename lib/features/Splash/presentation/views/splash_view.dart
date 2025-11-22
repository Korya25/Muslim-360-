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

    // لو الاحداثيات محفوظة
    if (latitude != null && longitude != null) {
      if (mounted) context.goNamed(AppRoutes.prayer);
      return;
    }

    // لو خدمة الموقع غير مفعلة
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      Future.delayed(const Duration(seconds: 1), _handleLocationFlow);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    // رفض دائم → افتح إعدادات التطبيق وليس الخروج
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      Future.delayed(const Duration(seconds: 1), _handleLocationFlow);
      return;
    }

    // لو مفيش إذن → اطلبه
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      Future.delayed(const Duration(milliseconds: 300), _handleLocationFlow);
      return;
    }

    // لو الإذن موجود
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      await _getAndSaveLocation();
      return;
    }

    Future.delayed(const Duration(seconds: 1), _handleLocationFlow);
  }

  Future<void> _getAndSaveLocation() async {
    final position = await _locationService.getCurrentLocation();
    if (position == null) {
      Future.delayed(const Duration(seconds: 1), _handleLocationFlow);
      return;
    }

    final prefs = SharedPref().getPreferenceInstance();
    await prefs.setDouble(PrefKeys.latitudeKey, position.latitude);
    await prefs.setDouble(PrefKeys.longitudeKey, position.longitude);

    if (mounted) context.goNamed(AppRoutes.prayer);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
