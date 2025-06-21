import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/domain/meals/entity/meal_entity.dart';
import 'package:fitness_app/features/meals/view_model/meals_cubit.dart';
import 'package:fitness_app/features/meals/view_model/meals_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/assets/app_colors.dart';
import '../../../../core/base/base_state.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../core/utils/shared_widgets/grid_item.dart';
import '../../../../domain/meals/entity/category_entity.dart';

class MealsGrid extends StatelessWidget {
  const MealsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MealsCubit>();
    return BlocConsumer<MealsCubit, MealsState>(
      listener: (context, state) {
        if (state.categoriesState is BaseSuccessState<List<CategoryEntity>>) {
          final categories =
              (state.categoriesState as BaseSuccessState<List<CategoryEntity>>)
                  .data!;
          cubit.doIntent(
            GetMealsAction(
              categories[state.selectedCategoryIndex].strCategory!,
            ),
          );
        }
      },
      builder: (context, state) {
        final mealsState = state.mealsState;
        final isError = mealsState is BaseErrorState;
        if (isError) {
          return Center(
            child: Text(
              (mealsState).errorMessage,
              style: const TextStyle(color: AppColors.red),
            ),
          );
        } else {
          final isLoading = mealsState is BaseLoadingState;
          final meals = mealsState is BaseSuccessState<List<MealEntity>>
              ? mealsState.data!
              : List.generate(
                  6,
                  (index) => MealEntity(strMeal: LocaleKeys.Loading.tr()),
                );
          if (meals.isEmpty) {
            return Center(child: Text(LocaleKeys.NoMealsFound.tr()));
          }
          return GridView.builder(
            itemCount: meals.length,
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 17,
              mainAxisSpacing: 17,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final meal = meals[index];
              return Skeletonizer(
                enabled: isLoading,
                child: GridItem(
                  title: meal.strMeal!,
                  imageUrl: meal.strMealThumb,
                  onTap: () {},
                ),
              );
            },
          );
        }
      },
    );
  }
}
