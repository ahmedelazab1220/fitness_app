import 'package:flutter/material.dart';

import '../../../../core/assets/app_colors.dart';

class IconVideo extends StatelessWidget {
  const IconVideo({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: AppColors.orange[AppColors.baseColor],
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: const Icon(
          Icons.play_arrow,
          color: AppColors.darkBlack,
          size: 40,
        ),
      ),
    );
  }
}
