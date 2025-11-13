extension StringExtensions on String {
  String truncate(int maxLength, {String omission = '...'}) {
    if (maxLength <= 0) return omission;

    if (length <= maxLength) return this;

    return '$omission${substring(0, maxLength)}';
  }
}
