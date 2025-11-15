class MetaInfo {
  final double latitude;
  final double longitude;
  final String timezone;
  final Method method;
  final String latitudeAdjustmentMethod;
  final String midnightMode;
  final String school;
  final Offset offset;

  const MetaInfo({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.method,
    required this.latitudeAdjustmentMethod,
    required this.midnightMode,
    required this.school,
    required this.offset,
  });
}

class Method {
  final int id;
  final String name;
  final MethodParams params;
  final Location location;

  const Method({
    required this.id,
    required this.name,
    required this.params,
    required this.location,
  });
}

class MethodParams {
  final double fajr;
  final double isha;

  const MethodParams({
    required this.fajr,
    required this.isha,
  });
}

class Location {
  final double latitude;
  final double longitude;

  const Location({
    required this.latitude,
    required this.longitude,
  });
}

class Offset {
  final int imsak;
  final int fajr;
  final int sunrise;
  final int dhuhr;
  final int asr;
  final int maghrib;
  final int sunset;
  final int isha;
  final int midnight;

  const Offset({
    required this.imsak,
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.sunset,
    required this.isha,
    required this.midnight,
  });
}
