import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/domain/meals/entity/meal_entity.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/utils/routes/app_routes.dart';
import '../../../../../core/utils/shared_widgets/grid_item.dart';

class RecommendationsMealBody extends StatelessWidget {
  final List<MealEntity> meals;
  final String currentMealId;

  const RecommendationsMealBody({
    super.key,
    required this.meals,
    required this.currentMealId,
  });

  @override
  Widget build(BuildContext context) {
    final filteredMeals = meals
        .where((meal) => meal.idMeal != currentMealId)
        .toList();
    filteredMeals.shuffle();
    final recommendations = filteredMeals.take(4).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.Recommendation.tr(),
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            itemCount: recommendations.length,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 17,
              mainAxisSpacing: 17,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final meal = recommendations[index];
              return GridItem(
                title: meal.strMeal,
                imageUrl: meal.strMealThumb,
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.mealDetailsRoute,
                    arguments: {
                      Constants.mealId: meal.idMeal,
                      Constants.mealRecommendation: meals,
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
