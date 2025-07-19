import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/utils/shared_widgets/shared_blured_container.dart';
import '../../../../../domain/meals/entity/meal_details_entity.dart';
import 'ingredient_item.dart';

class IngredientBody extends StatelessWidget {
  const IngredientBody({super.key, required this.meal});

  final MealDetailsEntity meal;

  @override
  Widget build(BuildContext context) {
    if (meal.ingredients.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.Ingredients.tr(),
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          SharedBluredContainer(
            padding: const EdgeInsets.all(8),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: meal.ingredients.length,
              itemBuilder: (_, index) {
                final item = meal.ingredients[index];
                return IngredientItem(name: item.name!, amount: item.measure!);
              },
              separatorBuilder: (_, _) => const SizedBox(height: 8),
            ),
          ),
        ],
      ),
    );
  }
}
