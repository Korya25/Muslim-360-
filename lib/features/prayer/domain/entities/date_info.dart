class DateInfo {
  final String readable;
  final String timestamp;
  final GregorianDate gregorian;
  final HijriDate hijri;

  const DateInfo({
    required this.readable,
    required this.timestamp,
    required this.gregorian,
    required this.hijri,
  });
}

class GregorianDate {
  final String date;
  final String format;
  final String day;
  final Weekday weekday;
  final Month month;
  final String year;
  final Designation designation;
  final bool lunarSighting;

  const GregorianDate({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.lunarSighting,
  });
}

class HijriDate {
  final String date;
  final String format;
  final String day;
  final Weekday weekday;
  final Month month;
  final String year;
  final Designation designation;
  final List<String> holidays;
  final List<String> adjustedHolidays;
  final String method;

  const HijriDate({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.holidays,
    required this.adjustedHolidays,
    required this.method,
  });
}

class Weekday {
  final String en;
  final String? ar;

  const Weekday({
    required this.en,
    this.ar,
  });
}

class Month {
  final int number;
  final String en;
  final String? ar;
  final int? days;

  const Month({
    required this.number,
    required this.en,
    this.ar,
    this.days,
  });
}

class Designation {
  final String abbreviated;
  final String expanded;

  const Designation({
    required this.abbreviated,
    required this.expanded,
  });
}
