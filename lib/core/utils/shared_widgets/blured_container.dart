import 'dart:ui';

import 'package:fitness_app/core/assets/app_colors.dart';
import 'package:flutter/material.dart';

class BluredContainer extends StatelessWidget {
  const BluredContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: AnimatedContainer(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          color: AppColors.darkgrey.withOpacity(0.3),
          duration: const Duration(milliseconds: 3000),
          child: child,
        ),
      ),
    );
  }
}
