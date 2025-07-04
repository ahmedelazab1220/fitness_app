import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/assets/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

class ExcerciseImage extends StatelessWidget {
  final muscleData;
  const ExcerciseImage({super.key, this.muscleData});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: muscleData.image ?? "",
          width: double.infinity,
          height: 350,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          height: 350,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.darkgrey, AppColors.darkBlack],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Text(
            muscleData.name ?? "",
            textAlign: TextAlign.center,
            style: AppTheme.appTheme.textTheme.bodyLarge?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
