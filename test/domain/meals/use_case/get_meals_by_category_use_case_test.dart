import 'package:fitness_app/domain/meals/use_case/get_meals_by_category_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/domain/meals/entity/meal_entity.dart';
import 'package:fitness_app/domain/meals/repo/meals_repo.dart';

import 'get_categories_use_case_test.mocks.dart';

@GenerateMocks([MealsRepo])
void main() {
  late MockMealsRepo mockMealsRepo;
  late GetMealsByCategoryUseCase getMealsUseCase;

  setUp(() {
    mockMealsRepo = MockMealsRepo();
    getMealsUseCase = GetMealsByCategoryUseCase(mockMealsRepo);
  });

  group('GetMealsByCategoryUseCase', () {
    const categoryName = 'Dessert';

    test(
      'returns SuccessResult<List<MealEntity>> when repository succeeds',
      () async {
        final meals = [
          MealEntity(idMeal: '1', strMeal: 'Cake', strMealThumb: null),
        ];

        provideDummy<Result<List<MealEntity>>>(
          SuccessResult<List<MealEntity>>(meals),
        );

        when(
          mockMealsRepo.getMealsByCategory(category: categoryName),
        ).thenAnswer((_) async => SuccessResult(meals));

        final result = await getMealsUseCase.call(category: categoryName);

        verify(
          mockMealsRepo.getMealsByCategory(category: categoryName),
        ).called(1);
        expect(result, isA<SuccessResult<List<MealEntity>>>());
      },
    );

    test(
      'returns FailureResult<List<MealEntity>> when repository fails',
      () async {
        final exception = Exception('Repo error');

        provideDummy<Result<List<MealEntity>>>(
          FailureResult<List<MealEntity>>(exception),
        );

        when(
          mockMealsRepo.getMealsByCategory(category: categoryName),
        ).thenAnswer((_) async => FailureResult<List<MealEntity>>(exception));

        final result = await getMealsUseCase.call(category: categoryName);

        verify(
          mockMealsRepo.getMealsByCategory(category: categoryName),
        ).called(1);
        expect(result, isA<FailureResult<List<MealEntity>>>());
      },
    );
  });
}
