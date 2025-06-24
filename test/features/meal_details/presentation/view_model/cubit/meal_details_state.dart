import 'package:fitness_app/features/details_food/presentation/view_model/cubit/meal_details_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_app/core/base/base_state.dart';
import 'package:fitness_app/domain/meal/entity/meal_details_entity.dart';

void main() {
  group('MealDetailsState', () {
    test('supports equality', () {
      final state1 = MealDetailsState(
        mealDetailsStatus: BaseLoadingState(),
        mealId: '',
      );
      final state2 = MealDetailsState(
        mealDetailsStatus: BaseLoadingState(),
        mealId: '',
      );

      expect(state1, equals(state2));
    });

    test('copyWith updates mealDetailsStatus', () {
      final initial = MealDetailsState(
        mealDetailsStatus: BaseLoadingState(),
        mealId: '',
      );
      final successState = BaseSuccessState<MealDetailsEntity>(data: null);

      final updated = initial.copyWith(mealDetailsStatus: successState);

      expect(updated.mealDetailsStatus, successState);
    });

    test('BaseSuccessState returns correct props', () {
      final meal = MealDetailsEntity(
        idMeal: '1',
        strMeal: 'Test Meal',
        strCategory: 'Test Category',
        strArea: 'Test Area',
        strInstructions: 'Do something',
        strMealThumb: 'image.jpg',
        strYoutube: 'video.com',
        ingredients: [],
      );
      final successState = MealDetailsState(
        mealDetailsStatus: BaseSuccessState<MealDetailsEntity>(data: meal),
        mealId: meal.idMeal,
      );

      expect(
        successState.mealDetailsStatus,
        isA<BaseSuccessState<MealDetailsEntity>>(),
      );
      expect(
        (successState.mealDetailsStatus as BaseSuccessState).data,
        equals(meal),
      );
    });

    test('BaseErrorState returns correct message', () {
      final errorState = MealDetailsState(
        mealDetailsStatus: BaseErrorState(errorMessage: 'Something went wrong'),
        mealId: '',
      );

      expect(errorState.mealDetailsStatus, isA<BaseErrorState>());
      expect(
        (errorState.mealDetailsStatus as BaseErrorState).errorMessage,
        equals('Something went wrong'),
      );
    });
  });
}
