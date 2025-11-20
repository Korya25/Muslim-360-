class PrayerDay {
  final Map<String, dynamic> timings;
  final Map<String, dynamic> date;

  PrayerDay({required this.timings, required this.date});

  factory PrayerDay.fromJson(Map<String, dynamic> json) {
    return PrayerDay(timings: json["timings"], date: json["date"]);
  }

  Map<String, dynamic> toJson() {
    return {"timings": timings, "date": date};
  }

  String _clean(String time) => time.split(" ").first;

  final Map<String, String> _prayerNamesArabic = {
    "Fajr": "الفجر",
    "Sunrise": "الشروق",
    "Dhuhr": "الظهر",
    "Asr": "العصر",
    "Sunset": "الغروب",
    "Maghrib": "المغرب",
    "Isha": "العشاء",
  };

  String get hijriFormatted {
    final hijri = date["hijri"];
    final monthName = hijri["month"]["ar"];
    final day = hijri["day"];
    final year = hijri["year"];
    return "$day $monthName $year هـ";
  }

  String get gregorianFormatted {
    final greg = date["gregorian"];
    final day = greg["day"];
    final month = greg["month"]["number"];
    final year = greg["year"];
    final weekdayEn = greg["weekday"]["en"];
    final weekdayAr = _translateWeekday(weekdayEn);
    return "$weekdayAr، $day $month $year";
  }

  String _translateWeekday(String en) {
    switch (en) {
      case "Saturday":
        return "السبت";
      case "Sunday":
        return "الأحد";
      case "Monday":
        return "الاثنين";
      case "Tuesday":
        return "الثلاثاء";
      case "Wednesday":
        return "الأربعاء";
      case "Thursday":
        return "الخميس";
      case "Friday":
        return "الجمعة";
      default:
        return en;
    }
  }

  Map<String, String> get prayerTimesClean {
    final cleaned = <String, String>{};
    timings.forEach((key, value) {
      cleaned[_prayerNamesArabic[key] ?? key] = _clean(value);
    });
    return cleaned;
  }

  final List<String> _order = [
    "Fajr",
    "Sunrise",
    "Dhuhr",
    "Asr",
    "Maghrib",
    "Isha",
  ];

  DateTime _toDate(String time) {
    final clean = _clean(time);
    final parts = clean.split(":");
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }

  String get nextPrayerName {
    final now = DateTime.now();
    for (final prayer in _order) {
      final t = _toDate(timings[prayer]);
      if (t.isAfter(now)) return _prayerNamesArabic[prayer]!;
    }
    return "الفجر";
  }

  String get nextPrayerTime {
    final now = DateTime.now();
    for (final prayer in _order) {
      final t = _toDate(timings[prayer]);
      if (t.isAfter(now)) return _clean(timings[prayer]);
    }
    return _clean(timings["Fajr"]);
  }

  String get nextPrayerRemaining {
    final now = DateTime.now();
    for (final prayer in _order) {
      final t = _toDate(timings[prayer]);
      if (t.isAfter(now)) {
        final diff = t.difference(now);
        final h = diff.inHours;
        final m = diff.inMinutes % 60;
        return "$h ساعة و $m دقيقة";
      }
    }
    final tomorrowFajr = _toDate(timings["Fajr"]).add(const Duration(days: 1));
    final diff = tomorrowFajr.difference(now);
    return "${diff.inHours} ساعة و ${diff.inMinutes % 60} دقيقة";
  }
}
