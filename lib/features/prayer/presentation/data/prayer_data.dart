/// Prayer Model
class Prayer {
  final String name;
  final String iconPath;
  final String timeKey;
  final String? sunnah;

  const Prayer({
    required this.name,
    required this.iconPath,
    required this.timeKey,
    this.sunnah,
  });
}

/// Fake prayers data
const List<Prayer> fakePrayers = [
  Prayer(
    name: 'الفجر',
    iconPath: 'assets/lottie/moon lottie animation.json',
    timeKey: 'fajr',
    sunnah: 'قبل الفجر: ركعتان',
  ),
  Prayer(
    name: 'الشروق',
    iconPath: 'assets/lottie/sunrise.json',
    timeKey: 'sunrise',
  ),
  Prayer(
    name: 'الظهر',
    iconPath: 'assets/lottie/Clear Day.json',
    timeKey: 'dhuhr',
    sunnah: 'قبل الظهر: أربع ركعات\nبعد الظهر: ركعتان',
  ),
  Prayer(name: 'العصر', iconPath: 'assets/lottie/Sunny.json', timeKey: 'asr'),
  Prayer(
    name: 'المغرب',
    iconPath: 'assets/lottie/sunset.json',
    timeKey: 'maghrib',
    sunnah: 'بعد المغرب: ركعتان',
  ),
  Prayer(
    name: 'العشاء',
    iconPath: 'assets/lottie/Weather-night.json',
    timeKey: 'isha',
    sunnah: 'بعد العشاء: ركعتان',
  ),
];

/// Fake prayer times for testing
const Map<String, String> fakePrayerTimes = {
  'fajr': '4:30 ص',
  'sunrise': '5:50 ص',
  'dhuhr': '12:15 م',
  'asr': '3:20 م',
  'maghrib': '6:05 م',
  'isha': '7:30 م',
};
