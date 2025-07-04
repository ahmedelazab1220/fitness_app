import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/base/base_state.dart';

class MealsState extends Equatable {
  final BaseState categoriesState;
  final BaseState mealsState;
  final int selectedCategoryIndex;

  const MealsState({
    required this.categoriesState,
    required this.mealsState,
    this.selectedCategoryIndex = 0,
  });

  MealsState copyWith({
    BaseState? categoriesState,
    BaseState? mealsState,
    int? selectedCategoryIndex,
  }) {
    return MealsState(
      categoriesState: categoriesState ?? this.categoriesState,
      mealsState: mealsState ?? this.mealsState,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
    );
  }

  @override
  List<Object?> get props => [
    categoriesState,
    mealsState,
    selectedCategoryIndex,
  ];
}

sealed class MealsAction {}

class GetCategoriesAction extends MealsAction {}

class GetMealsAction extends MealsAction {
  final String categoryName;

  GetMealsAction(this.categoryName);
}

class SelectCategoryAction extends MealsAction {
  final int index;

  SelectCategoryAction(this.index);
}
