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
    "الفجر": "ركعتان قبلها",
    "الظهر": "أربع ركعات قبلها وركعتان بعدها",
    "العصر": "",
    "المغرب": "ركعتان بعدها",
    "العشاء": "ركعتان بعدها",
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

  String get nextPrayerName {
    final now = DateTime.now();

    final times = prayerTimesClean.entries.map((entry) {
      final parts = entry.value.split(":");
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      final dt = DateTime(now.year, now.month, now.day, hour, minute);
      return MapEntry(entry.key, dt);
    }).toList()..sort((a, b) => a.value.compareTo(b.value));

    for (var entry in times) {
      if (entry.value.isAfter(now)) return entry.key;
    }

    return "الفجر";
  }
}
