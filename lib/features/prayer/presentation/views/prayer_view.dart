import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim360/core/theme/style/app_colors.dart';
import 'package:muslim360/features/prayer/presentation/cubit/prayer_cubit.dart';
import 'package:muslim360/features/prayer/presentation/widgets/features_list.dart';
import 'package:muslim360/features/prayer/presentation/widgets/prayer_body.dart';

class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: AppColors.iconPrimary,
        backgroundColor: AppColors.scaffoldBackground,
        onRefresh: () => context.read<PrayerCubit>().refreshData(),
        child: const SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrayerBody(),
                SizedBox(height: 22),
                PrayerFeaturesSection(),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
