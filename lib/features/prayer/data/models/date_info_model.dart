import '../../domain/entities/date_info.dart';

class DateInfoModel extends DateInfo {
  const DateInfoModel({
    required super.readable,
    required super.timestamp,
    required super.gregorian,
    required super.hijri,
  });

  factory DateInfoModel.fromJson(Map<String, dynamic> json) {
    return DateInfoModel(
      readable: json['readable'] as String,
      timestamp: json['timestamp'] as String,
      gregorian: GregorianDateModel.fromJson(json['gregorian'] as Map<String, dynamic>),
      hijri: HijriDateModel.fromJson(json['hijri'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'readable': readable,
      'timestamp': timestamp,
      'gregorian': (gregorian as GregorianDateModel).toJson(),
      'hijri': (hijri as HijriDateModel).toJson(),
    };
  }
}

class GregorianDateModel extends GregorianDate {
  const GregorianDateModel({
    required super.date,
    required super.format,
    required super.day,
    required super.weekday,
    required super.month,
    required super.year,
    required super.designation,
    required super.lunarSighting,
  });

  factory GregorianDateModel.fromJson(Map<String, dynamic> json) {
    return GregorianDateModel(
      date: json['date'] as String,
      format: json['format'] as String,
      day: json['day'] as String,
      weekday: WeekdayModel.fromJson(json['weekday'] as Map<String, dynamic>),
      month: MonthModel.fromJson(json['month'] as Map<String, dynamic>),
      year: json['year'] as String,
      designation: DesignationModel.fromJson(json['designation'] as Map<String, dynamic>),
      lunarSighting: json['lunarSighting'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'format': format,
      'day': day,
      'weekday': (weekday as WeekdayModel).toJson(),
      'month': (month as MonthModel).toJson(),
      'year': year,
      'designation': (designation as DesignationModel).toJson(),
      'lunarSighting': lunarSighting,
    };
  }
}

class HijriDateModel extends HijriDate {
  const HijriDateModel({
    required super.date,
    required super.format,
    required super.day,
    required super.weekday,
    required super.month,
    required super.year,
    required super.designation,
    required super.holidays,
    required super.adjustedHolidays,
    required super.method,
  });

  factory HijriDateModel.fromJson(Map<String, dynamic> json) {
    return HijriDateModel(
      date: json['date'] as String,
      format: json['format'] as String,
      day: json['day'] as String,
      weekday: WeekdayModel.fromJson(json['weekday'] as Map<String, dynamic>),
      month: MonthModel.fromJson(json['month'] as Map<String, dynamic>),
      year: json['year'] as String,
      designation: DesignationModel.fromJson(json['designation'] as Map<String, dynamic>),
      holidays: (json['holidays'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      adjustedHolidays: (json['adjustedHolidays'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      method: json['method'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'format': format,
      'day': day,
      'weekday': (weekday as WeekdayModel).toJson(),
      'month': (month as MonthModel).toJson(),
      'year': year,
      'designation': (designation as DesignationModel).toJson(),
      'holidays': holidays,
      'adjustedHolidays': adjustedHolidays,
      'method': method,
    };
  }
}

class WeekdayModel extends Weekday {
  const WeekdayModel({
    required super.en,
    super.ar,
  });

  factory WeekdayModel.fromJson(Map<String, dynamic> json) {
    return WeekdayModel(
      en: json['en'] as String,
      ar: json['ar'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'en': en,
      if (ar != null) 'ar': ar,
    };
  }
}

class MonthModel extends Month {
  const MonthModel({
    required super.number,
    required super.en,
    super.ar,
    super.days,
  });

  factory MonthModel.fromJson(Map<String, dynamic> json) {
    return MonthModel(
      number: json['number'] as int,
      en: json['en'] as String,
      ar: json['ar'] as String?,
      days: json['days'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'en': en,
      if (ar != null) 'ar': ar,
      if (days != null) 'days': days,
    };
  }
}

class DesignationModel extends Designation {
  const DesignationModel({
    required super.abbreviated,
    required super.expanded,
  });

  factory DesignationModel.fromJson(Map<String, dynamic> json) {
    return DesignationModel(
      abbreviated: json['abbreviated'] as String,
      expanded: json['expanded'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'abbreviated': abbreviated,
      'expanded': expanded,
    };
  }
}

