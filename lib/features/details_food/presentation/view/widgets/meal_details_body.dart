import 'package:fitness_app/core/utils/shared_widgets/shared_blured_container.dart';
import 'package:fitness_app/domain/meals/entity/meal_details_entity.dart';
import 'package:fitness_app/domain/meals/entity/meal_entity.dart';
import 'package:fitness_app/features/details_food/presentation/view/widgets/meal_image.dart';
import 'package:fitness_app/features/details_food/presentation/view/widgets/recommendations_meal_body.dart';
import 'package:flutter/material.dart';
import 'ingredient_body.dart';

class MealDetailsBody extends StatelessWidget {
  final MealDetailsEntity meal;
  final List<MealEntity> meals;

  const MealDetailsBody({super.key, required this.meal, required this.meals});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SharedBluredContainer(
          padding: EdgeInsets.zero,
          child: MealImage(meal: meal),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                IngredientBody(meal: meal),
                RecommendationsMealBody(
                  meals: meals,
                  currentMealId: meal.idMeal,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
