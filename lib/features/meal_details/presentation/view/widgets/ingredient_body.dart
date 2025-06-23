import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/utils/shared_widget/blured_container.dart';
import '../../../../../domain/meal/entity/meal_details_entity.dart';
import 'ingredient_item.dart';

class IngredientBody extends StatelessWidget {
  const IngredientBody({super.key, required this.theme, required this.meal});

  final ThemeData theme;
  final MealDetailsEntity meal;

@override
Widget build(BuildContext context) {
  if (meal.ingredients.isEmpty) return const SizedBox.shrink();

  return BluredContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.Ingredients.tr(),
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: meal.ingredients.length,
          itemBuilder: (_, index) {
            final item = meal.ingredients[index];
            return IngredientItem(name: item.name, amount: item.measure);
          },
          separatorBuilder: (_, _) => const SizedBox(height: 8),
        ),
      ],
    ),
  );
}
}