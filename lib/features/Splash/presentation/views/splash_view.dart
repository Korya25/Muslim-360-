import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:muslim360/core/presentation/widgets/animations/animate_do.dart';
import 'package:muslim360/core/routing/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateNext();
  }

  void _navigateNext() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.goNamed(AppRoutes.prayer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppAnimations.elasticIn(
          CircleAvatar(
            radius: 70,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(500),
              child: Image.asset('assets/image/native_splash/logo.png'),
            ),
          ),
          duration: const Duration(milliseconds: 800),
        ),
      ),
    );
  }
}
