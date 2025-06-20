import 'dart:ui';

import 'package:flutter/material.dart';

import '../../assets/app_colors.dart';

class SharedBluredContainer extends StatelessWidget {
  const SharedBluredContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: AnimatedContainer(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
          color: AppColors.darkgrey.withAlpha(150),
          duration: const Duration(milliseconds: 3000),
          child: child,
        ),
      ),
    );
  }
}
