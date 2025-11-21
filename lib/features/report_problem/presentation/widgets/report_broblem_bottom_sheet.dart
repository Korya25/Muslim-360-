import 'package:flutter/material.dart';
import 'package:muslim360/core/theme/style/app_colors.dart';
import 'package:muslim360/core/theme/fonts/app_text_styles.dart';

class ReportProblemBottomSheet extends StatefulWidget {
  final void Function(String problem, String? contact)? onSubmit;

  const ReportProblemBottomSheet({super.key, this.onSubmit});

  @override
  State<ReportProblemBottomSheet> createState() =>
      _ReportProblemBottomSheetState();
}

class _ReportProblemBottomSheetState extends State<ReportProblemBottomSheet> {
  final TextEditingController _problemController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  bool _isSubmitting = false;

  void _submit() async {
    final problemText = _problemController.text.trim();
    final contactText = _contactController.text.trim().isEmpty
        ? null
        : _contactController.text.trim();

    if (problemText.isEmpty) return;

    setState(() => _isSubmitting = true);

    // هنا لاحقاً تربطه بـ Firebase
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() => _isSubmitting = false);
      widget.onSubmit?.call(problemText, contactText);
      Navigator.of(context).pop(); // اغلاق الـ Bottom Sheet بعد الإرسال
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 16,
        left: 16,
        right: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'أبلغ عن مشكلة',
            style: AppTextStyles.body13BoldWhite.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _problemController,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'صف مشكلتك هنا...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _contactController,
            decoration: const InputDecoration(
              hintText: 'وسيلة التواصل (اختياري)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isSubmitting ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.iconPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('إرسال'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
