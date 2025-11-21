import 'package:geolocator/geolocator.dart';
import 'package:muslim360/core/services/sharedpref/pref_keys.dart';
import 'package:muslim360/core/services/sharedpref/shared_pref.dart';

class LocationService {
  final SharedPref _sharedPref = SharedPref();

  /// Get location and store latitude & longitude in SharedPreferences
  Future<Position?> getCurrentLocation({Function(String)? onError}) async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        await Future.delayed(const Duration(seconds: 1));
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          onError?.call('فعل خدمة الموقع');
          return null;
        }
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        onError?.call('تم رفض إذن الموقع');
        return null;
      } else if (permission == LocationPermission.deniedForever) {
        onError?.call('تم رفض الإذن نهائياً');
        await Geolocator.openAppSettings();
        return null;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 30),
      );

      // حفظ الإحداثيات في SharedPreferences
      await _sharedPref.setDouble(PrefKeys.latitudeKey, position.latitude);
      await _sharedPref.setDouble(PrefKeys.longitudeKey, position.longitude);

      return position;
    } catch (e) {
      onError?.call(e.toString());
      return null;
    }
  }

  Future<Map<String, double>?> getCachedLocation() async {
    final lat = _sharedPref.getDouble(PrefKeys.latitudeKey);
    final lon = _sharedPref.getDouble(PrefKeys.longitudeKey);
    if (lat != null && lon != null) {
      return {'latitude': lat, 'longitude': lon};
    }
    return null;
  }
}
