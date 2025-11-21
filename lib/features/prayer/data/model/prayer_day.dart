class Prayer {
  final String nameArabic;
  final String nameEnglish;
  final String iconPath;
  final String? sunnah;

  Prayer({
    required this.nameArabic,
    required this.nameEnglish,
    required this.iconPath,
    this.sunnah,
  });

  String get name => nameArabic;
}

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

  String _to12Hour(String time24) {
    final parts = time24.split(":");
    int hour = int.parse(parts[0]);
    final minute = parts[1];
    final suffix = hour >= 12 ? "م" : "ص";
    hour = hour % 12;
    if (hour == 0) hour = 12;
    return "$hour:$minute $suffix";
  }

  final Map<String, String> prayerNamesArabic = {
    "Fajr": "الفجر",
    "Dhuhr": "الظهر",
    "Asr": "العصر",
    "Sunset": "الغروب",
    "Maghrib": "المغرب",
    "Isha": "العشاء",
  };

  final Map<String, String> prayerIcons = {
    "الفجر": "assets/lottie/moon lottie animation.json",
    "الظهر": "assets/lottie/Clear Day.json",
    "العصر": "assets/lottie/Sunny.json",
    "المغرب": "assets/lottie/sunset.json",
    "العشاء": "assets/lottie/Weather-night.json",
  };

  Map<String, String> get prayerTimesClean {
    final cleaned = <String, String>{};
    timings.forEach((key, value) {
      final arabicName = prayerNamesArabic[key] ?? key;
      cleaned[arabicName] = _clean(value);
    });
    return cleaned;
  }

  Map<String, String> get prayerTimesCleanForDisplay {
    final cleaned = <String, String>{};
    timings.forEach((key, value) {
      final arabicName = prayerNamesArabic[key] ?? key;
      cleaned[arabicName] = _to12Hour(_clean(value));
    });
    return cleaned;
  }

  Map<String, String> get sunnahMap => {
    "الفجر": "ركعتان قبل الفجر",
    "الظهر": "أربع ركعات قبل الظهر وركعتان بعد الظهر",
    "العصر": "",
    "المغرب": "ركعتان بعد المغرب",
    "العشاء": "ركعتان بعد العشاء",
  };

  List<Prayer> get prayers {
    final arabicToEnglish = {
      "الفجر": "Fajr",
      "الظهر": "Dhuhr",
      "العصر": "Asr",
      "المغرب": "Maghrib",
      "العشاء": "Isha",
    };

    final prayerOrder = ["الفجر", "الظهر", "العصر", "المغرب", "العشاء"];

    return prayerOrder.where((name) => prayerTimesClean.containsKey(name)).map((
      arabicName,
    ) {
      final sunnah = sunnahMap[arabicName];
      final englishName = arabicToEnglish[arabicName] ?? arabicName;

      return Prayer(
        nameArabic: arabicName,
        nameEnglish: englishName,
        iconPath: prayerIcons[arabicName] ?? "assets/lottie/Clear Day.json",
        sunnah: sunnah?.isEmpty ?? true ? null : sunnah,
      );
    }).toList();
  }

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
    final monthName = _translateMonth(greg["month"]["number"]);
    final year = greg["year"];
    final weekdayEn = greg["weekday"]["en"];
    return "${_translateWeekday(weekdayEn)}، $day $monthName $year";
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

  String _translateMonth(int monthNumber) {
    const months = [
      "",
      "يناير",
      "فبراير",
      "مارس",
      "أبريل",
      "مايو",
      "يونيو",
      "يوليو",
      "أغسطس",
      "سبتمبر",
      "أكتوبر",
      "نوفمبر",
      "ديسمبر",
    ];
    if (monthNumber < 1 || monthNumber > 12) return "";
    return months[monthNumber];
  }

  // حساب الصلاة القادمة والأوقات المتعلقة بها
  Prayer get nextPrayer {
    final now = DateTime.now();
    final prayers = this.prayers;

    for (var prayer in prayers) {
      final timeStr = prayerTimesClean[prayer.name] ?? '00:00';
      final parts = timeStr.split(":");
      if (parts.length < 2) continue;

      final time = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );

      if (time.isAfter(now)) {
        return prayer;
      }
    }

    return prayers.firstWhere(
      (p) => p.name == 'الفجر',
      orElse: () => prayers.first,
    );
  }

  DateTime get nextPrayerDateTime {
    final now = DateTime.now();
    final timeStr = prayerTimesClean[nextPrayer.name] ?? '00:00';
    final parts = timeStr.split(":");

    if (parts.length < 2) {
      return now.add(const Duration(hours: 1));
    }

    var time = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );

    // إذا كان الوقت في الماضي، أضفنا يوم (للفجر)
    if (time.isBefore(now)) {
      time = time.add(const Duration(days: 1));
    }

    return time;
  }

  // الحصول على وقت الصلاة السابقة كـ DateTime
  DateTime get previousPrayerDateTime {
    final now = DateTime.now();
    final prayers = this.prayers;
    DateTime? prev;

    for (var prayer in prayers) {
      final timeStr = prayerTimesClean[prayer.name] ?? '00:00';
      final parts = timeStr.split(":");
      if (parts.length < 2) continue;

      final time = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );

      if (time.isBefore(now)) {
        prev = time;
      }
    }

    if (prev == null) {
      final ishaTime = prayerTimesClean['العشاء'] ?? '00:00';
      final parts = ishaTime.split(":");
      prev = DateTime(
        now.year,
        now.month,
        now.day - 1,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );
    }

    return prev;
  }

  // الحصول على الوقت المتبقي حتى الصلاة القادمة
  Duration get remainingDurationToNextPrayer {
    return nextPrayerDateTime.difference(DateTime.now());
  }

  // الحصول على الوقت المتبقي كـ String (HH:MM:SS)
  String get remainingTimeFormatted {
    final diff = remainingDurationToNextPrayer;
    return "${diff.inHours.toString().padLeft(2, '0')}:${(diff.inMinutes % 60).toString().padLeft(2, '0')}:${(diff.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  double get progressToNextPrayer {
    final totalSeconds = nextPrayerDateTime
        .difference(previousPrayerDateTime)
        .inSeconds;
    final elapsedSeconds = DateTime.now()
        .difference(previousPrayerDateTime)
        .inSeconds;

    if (totalSeconds <= 0) return 1.0;
    return (elapsedSeconds / totalSeconds).clamp(0.001, 1.0);
  }
}
