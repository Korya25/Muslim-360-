import 'package:flutter/material.dart';

class PrayerEmptyWidget extends StatelessWidget {
  const PrayerEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          SizedBox(height: 40),
          Icon(Icons.info_outline, size: 65),
          SizedBox(height: 16),
          Text('لا توجد بيانات للصلاة لهذا اليوم'),
        ],
      ),
    );
  }
}
