import 'package:fitness_app/core/assets/app_colors.dart';
import 'package:flutter/material.dart';

class SelectedGenderCardItemWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData iconData;

  const SelectedGenderCardItemWidget({
    super.key,
    required this.text,
    this.isSelected = false,
    required this.onTap,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppColors.orange : Colors.transparent,
          border: Border.all(
            color: AppColors.white[AppColors.colorCode20]!,
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Icon(
              iconData,
              size: 50,
              color: isSelected
                  ? AppColors.white
                  : AppColors.white[AppColors.colorCode20]!,
            ),
            const SizedBox(height: 8.0),
            Text(text),
          ],
        ),
      ),
    );
  }
}
