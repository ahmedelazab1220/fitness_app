import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/utils/l10n/locale_keys.g.dart';
import 'package:fitness_app/domain/meals/entity/category_entity.dart';
import 'package:fitness_app/features/meals/view_model/meals_cubit.dart';
import 'package:fitness_app/features/meals/view_model/meals_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/assets/app_colors.dart';
import '../../../../core/base/base_state.dart';
import '../../../../core/utils/shared_widgets/custom_tab_bar.dart';
import 'meals_grid.dart';

class MealsBody extends StatelessWidget {
  const MealsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsCubit, MealsState>(
      builder: (context, state) {
        final cubit = context.read<MealsCubit>();
        final categoriesState = state.categoriesState;
        final isError = categoriesState is BaseErrorState;
        if (isError) {
          return Center(
            child: Text(
              categoriesState.errorMessage,
              style: const TextStyle(color: AppColors.red),
            ),
          );
        }
        final isLoading = categoriesState is BaseLoadingState;
        final categories =
            categoriesState is BaseSuccessState<List<CategoryEntity>>
            ? categoriesState.data!
            : List.generate(
                6,
                (index) => CategoryEntity(strCategory: LocaleKeys.Loading.tr()),
              );
        final tabs = categories
            .map((category) => category.strCategory ?? '')
            .toList();
        return Column(
          children: [
            Skeletonizer(
              enabled: isLoading,
              child: CustomTabBar(
                tabs: tabs,
                selectedIndex: state.selectedCategoryIndex,
                onTap: (index) => cubit.doIntent(SelectCategoryAction(index)),
              ),
            ),
            const SizedBox(height: 16),
            const Expanded(child: MealsGrid()),
          ],
        );
      },
    );
  }
}
