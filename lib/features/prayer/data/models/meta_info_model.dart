import '../../domain/entities/meta_info.dart';

class MetaInfoModel extends MetaInfo {
  const MetaInfoModel({
    required super.latitude,
    required super.longitude,
    required super.timezone,
    required super.method,
    required super.latitudeAdjustmentMethod,
    required super.midnightMode,
    required super.school,
    required super.offset,
  });

  factory MetaInfoModel.fromJson(Map<String, dynamic> json) {
    return MetaInfoModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      timezone: json['timezone'] as String,
      method: MethodModel.fromJson(json['method'] as Map<String, dynamic>),
      latitudeAdjustmentMethod: json['latitudeAdjustmentMethod'] as String,
      midnightMode: json['midnightMode'] as String,
      school: json['school'] as String,
      offset: OffsetModel.fromJson(json['offset'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'timezone': timezone,
      'method': (method as MethodModel).toJson(),
      'latitudeAdjustmentMethod': latitudeAdjustmentMethod,
      'midnightMode': midnightMode,
      'school': school,
      'offset': (offset as OffsetModel).toJson(),
    };
  }
}

class MethodModel extends Method {
  const MethodModel({
    required super.id,
    required super.name,
    required super.params,
    required super.location,
  });

  factory MethodModel.fromJson(Map<String, dynamic> json) {
    return MethodModel(
      id: json['id'] as int,
      name: json['name'] as String,
      params: MethodParamsModel.fromJson(json['params'] as Map<String, dynamic>),
      location: LocationModel.fromJson(json['location'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'params': (params as MethodParamsModel).toJson(),
      'location': (location as LocationModel).toJson(),
    };
  }
}

class MethodParamsModel extends MethodParams {
  const MethodParamsModel({
    required super.fajr,
    required super.isha,
  });

  factory MethodParamsModel.fromJson(Map<String, dynamic> json) {
    return MethodParamsModel(
      fajr: (json['Fajr'] as num).toDouble(),
      isha: (json['Isha'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Fajr': fajr,
      'Isha': isha,
    };
  }
}

class LocationModel extends Location {
  const LocationModel({
    required super.latitude,
    required super.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class OffsetModel extends Offset {
  const OffsetModel({
    required super.imsak,
    required super.fajr,
    required super.sunrise,
    required super.dhuhr,
    required super.asr,
    required super.maghrib,
    required super.sunset,
    required super.isha,
    required super.midnight,
  });

  factory OffsetModel.fromJson(Map<String, dynamic> json) {
    return OffsetModel(
      imsak: json['Imsak'] as int? ?? 0,
      fajr: json['Fajr'] as int? ?? 0,
      sunrise: json['Sunrise'] as int? ?? 0,
      dhuhr: json['Dhuhr'] as int? ?? 0,
      asr: json['Asr'] as int? ?? 0,
      maghrib: json['Maghrib'] as int? ?? 0,
      sunset: json['Sunset'] as int? ?? 0,
      isha: json['Isha'] as int? ?? 0,
      midnight: json['Midnight'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Imsak': imsak,
      'Fajr': fajr,
      'Sunrise': sunrise,
      'Dhuhr': dhuhr,
      'Asr': asr,
      'Maghrib': maghrib,
      'Sunset': sunset,
      'Isha': isha,
      'Midnight': midnight,
    };
  }
}

