import 'package:fitness_app/core/base/base_state.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/domain/meals/entity/category_entity.dart';
import 'package:fitness_app/domain/meals/use_case/get_categories_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/meals/entity/meal_entity.dart';

import '../../../../domain/meals/use_case/get_meals_by_category_use_case.dart';
import 'meals_state.dart';

@injectable
class MealsCubit extends Cubit<MealsState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetMealsByCategoryUseCase _getMealsByCategoryUseCase;

  MealsCubit(this._getCategoriesUseCase, this._getMealsByCategoryUseCase)
    : super(
        MealsState(
          categoriesState: BaseInitialState(),
          mealsState: BaseInitialState(),
        ),
      );

  void doIntent(MealsAction action) {
    switch (action) {
      case GetCategoriesAction():
        _getCategories();
      case GetMealsAction():
        _getMeals(action.categoryName);
      case SelectCategoryAction():
        _selectCategory(action.index);
    }
  }

  Future<void> _getCategories() async {
    emit(state.copyWith(categoriesState: BaseLoadingState()));
    final result = await _getCategoriesUseCase();
    switch (result) {
      case SuccessResult<List<CategoryEntity>>():
        emit(
          state.copyWith(categoriesState: BaseSuccessState(data: result.data)),
        );
      case FailureResult<List<CategoryEntity>>():
        emit(
          state.copyWith(
            categoriesState: BaseErrorState(
              errorMessage: result.exception.toString(),
            ),
          ),
        );
    }
  }

  Future<void> _getMeals(String categoryName) async {
    emit(state.copyWith(mealsState: BaseLoadingState()));
    final result = await _getMealsByCategoryUseCase(category: categoryName);
    switch (result) {
      case SuccessResult<List<MealEntity>>():
        emit(state.copyWith(mealsState: BaseSuccessState(data: result.data)));
      case FailureResult<List<MealEntity>>():
        emit(
          state.copyWith(
            mealsState: BaseErrorState(
              errorMessage: result.exception.toString(),
            ),
          ),
        );
    }
  }

  void _selectCategory(int index) {
    if (index == state.selectedCategoryIndex) return;
    final selectedCategory =
        (state.categoriesState as BaseSuccessState<List<CategoryEntity>>)
            .data![index];
    _getMeals(selectedCategory.strCategory!);
    emit(state.copyWith(selectedCategoryIndex: index));
  }
}
