import 'package:flutter/material.dart';
import 'package:muslim360/core/theme/style/app_colors.dart';

class PrayerErrorWidget extends StatefulWidget {
  final Future<void> Function() onRetry;

  const PrayerErrorWidget({super.key, required this.onRetry});

  @override
  State<PrayerErrorWidget> createState() => _PrayerErrorWidgetState();
}

class _PrayerErrorWidgetState extends State<PrayerErrorWidget> {
  bool _isLoading = false;

  Future<void> _handleRetry() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      await widget.onRetry();
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 40),
          Icon(Icons.wifi_off, size: 65, color: AppColors.grey.withAlpha(120)),
          const SizedBox(height: 16),

          const Text(
            'تعذر تحميل بيانات الصلاة',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          const Text(
            'تحقق من اتصال الإنترنت ثم حاول مرة أخرى.',
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),

          GestureDetector(
            onTap: _handleRetry,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                color: AppColors.iconPrimary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'إعادة المحاولة',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
