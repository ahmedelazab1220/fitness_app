import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/domain/meals/entity/meal_details_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../core/assets/app_colors.dart';

class MealImage extends StatelessWidget {
  final MealDetailsEntity meal;

  const MealImage({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: meal.strMealThumb,
          width: double.infinity,
          height: 350,
          fit: BoxFit.fill,
          color: AppColors.darkgrey.withAlpha(150),
          colorBlendMode: BlendMode.darken,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.darkgrey, AppColors.darkBlack],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          top: 48,
          left: 16,
          child: CircleAvatar(
            backgroundColor: AppColors.orange,
            radius: 14,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                size: 28,
                Icons.arrow_back_rounded,
                color: AppColors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                meal.strMeal,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                meal.strInstructions,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
