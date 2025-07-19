import 'package:flutter/material.dart';

import '../../../../../core/assets/app_colors.dart';

class DotItems extends StatelessWidget {
  const DotItems({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: isActive ? 24 : 8,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.orange
            : AppColors.white[AppColors.colorCode20],
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
