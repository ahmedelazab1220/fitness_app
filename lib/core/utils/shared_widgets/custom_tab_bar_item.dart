import 'package:flutter/material.dart';
import '../../assets/app_colors.dart';

class CustomTabBarItem extends StatelessWidget {
  final String tab;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomTabBarItem({
    super.key,
    required this.tab,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.orange : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        alignment: Alignment.center,
        child: Text(
          tab,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: isSelected
                ? AppColors.white
                : AppColors.white[AppColors.colorCode30],
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
