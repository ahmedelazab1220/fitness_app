import 'dart:ui';

import 'package:flutter/material.dart';

import '../../assets/app_colors.dart';

class BluredContainer extends StatelessWidget {
  const BluredContainer({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: AnimatedContainer(
          padding:
              padding ??
              const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          color: AppColors.darkgrey.withAlpha(150),
          duration: const Duration(milliseconds: 3000),
          child: child,
        ),
      ),
    );
  }
}
