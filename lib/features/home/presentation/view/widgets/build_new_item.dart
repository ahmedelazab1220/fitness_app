import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../domain/home/entity/exercise_entity.dart';
import '../../../../../domain/home/entity/meal_entity.dart';

class BuildNewItem<T> extends StatelessWidget {
  const BuildNewItem({super.key, required this.item, this.height = 105.0});

  final T? item;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: AppColors.darkgrey,
        highlightColor: AppColors.white[AppColors.colorCode80]!,
        duration: const Duration(seconds: 1),
      ),
      enabled: item == null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: AppColors.darkgrey,
              child: CachedNetworkImage(
                imageUrl: _getImageUrl() ?? '',
                fit: BoxFit.cover,
                width: height,
                height: height,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(color: AppColors.darkgrey),
                ),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, color: AppColors.red, size: 45),
              ),
            ),
            Container(
              width: height,
              color: AppColors.darkgrey.withAlpha(220),
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 8.0,
              ),
              child: Text(
                _getName() ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _getImageUrl() {
    if (item == null) return '';
    if (item is ExerciseEntity) {
      return (item as ExerciseEntity).imageUrl;
    } else if (item is MealEntity) {
      return (item as MealEntity).imageUrl;
    }
    return '';
  }

  String? _getName() {
    if (item == null) return '';
    if (item is ExerciseEntity) {
      return (item as ExerciseEntity).name;
    } else if (item is MealEntity) {
      return (item as MealEntity).name;
    }
    return '';
  }
}
