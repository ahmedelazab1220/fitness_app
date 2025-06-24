import 'package:flutter/material.dart';

import '../../../../../core/assets/app_colors.dart';

class IngredientItem extends StatelessWidget {
  final String name;
  final String amount;

  const IngredientItem({super.key, required this.name, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: Theme.of(context).textTheme.bodyMedium),
            Text(
              amount,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.orange),
            ),
          ],
        ),
        const Divider(color: AppColors.darkgrey, thickness: 1),
      ],
    );
  }
}
