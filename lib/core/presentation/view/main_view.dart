import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:muslim360/core/presentation/widgets/bottom_nav/custom_nav_bar.dart';

class MainView extends StatelessWidget {
  final GoRouterState state;
  final Widget child;

  const MainView({super.key, required this.state, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          child,
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomNavBar(currentRoute: state.uri.path),
          ),
        ],
      ),
    );
  }
}
