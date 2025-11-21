import 'package:flutter/material.dart';
import 'package:muslim360/core/theme/fonts/app_text_styles.dart';
import 'package:muslim360/core/theme/style/app_colors.dart';
import 'package:muslim360/features/report_problem/presentation/widgets/report_broblem_bottom_sheet.dart';

class PrayerErrorWidget extends StatefulWidget {
  final Future<void> Function() onRetry;

  const PrayerErrorWidget({super.key, required this.onRetry});

  @override
  State<PrayerErrorWidget> createState() => _PrayerErrorWidgetState();
}

class _PrayerErrorWidgetState extends State<PrayerErrorWidget> {
  bool _isRetrying = false;

  Future<void> _handleRetry() async {
    if (_isRetrying) return;

    setState(() => _isRetrying = true);

    try {
      await widget.onRetry();
    } finally {
      if (mounted) setState(() => _isRetrying = false);
    }
  }

  void _handleReportProblem() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const ReportProblemBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 40),
            Icon(
              Icons.wifi_off,
              size: 65,
              color: AppColors.grey.withAlpha(120),
            ),
            const SizedBox(height: 16),
            Text(
              'تعذر تحميل بيانات الصلاة',
              style: AppTextStyles.amiri15W700White,
            ),

            const SizedBox(height: 24),

            // Retry Button
            SizedBox(
              width: 180,
              child: ElevatedButton(
                onPressed: _isRetrying ? null : _handleRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.iconPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: _isRetrying
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'إعادة المحاولة',
                        style: AppTextStyles.amiri15W700White,
                      ),
              ),
            ),

            const SizedBox(height: 32),

            // Report Problem Button
            GestureDetector(
              onTap: _handleReportProblem,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondaryBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'إذا واجهت أي مشكلة، نحب أن نسمع منك اضغط هنا لإرسال بلاغك.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.amiri15W700White,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
