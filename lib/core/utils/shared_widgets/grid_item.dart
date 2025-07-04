import 'package:flutter/material.dart';

import '../../assets/app_colors.dart';

class GridItem extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final VoidCallback? onTap;

  const GridItem({super.key, required this.title, this.imageUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: imageUrl != null
              ? DecorationImage(
                  image: NetworkImage(imageUrl!),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                    AppColors.black.withOpacity(0.4),
                    BlendMode.darken,
                  ),
                )
              : null,
          color: Colors.black.withAlpha(100),
        ),
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(bottom: 16, left: 8, right: 8),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
