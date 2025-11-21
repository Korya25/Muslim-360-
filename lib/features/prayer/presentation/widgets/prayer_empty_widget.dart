import 'package:flutter/material.dart';
import 'package:muslim360/core/theme/fonts/app_text_styles.dart';
import 'package:muslim360/core/theme/style/app_colors.dart';
import 'package:muslim360/features/report_problem/presentation/widgets/report_broblem_bottom_sheet.dart';

class PrayerEmptyWidget extends StatelessWidget {
  const PrayerEmptyWidget({super.key});

  void _handleReportProblem(BuildContext context) {
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
              Icons.info_outline,
              size: 65,
              color: AppColors.grey.withAlpha(120),
            ),
            const SizedBox(height: 16),
            Text(
              'لا توجد بيانات الصلاة لهذا اليوم. '
              'إذا لاحظت أي مشكلة، نود سماع رأيك لمساعدتنا ',
              style: AppTextStyles.amiri15W700White,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Report Problem Button
            GestureDetector(
              onTap: () => _handleReportProblem(context),
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
                  'اضغط هنا لإرسال بلاغك أو مشاركة مشكلتك معنا',
                  style: AppTextStyles.amiri15W700White,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
