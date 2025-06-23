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
        provideDummy<Result<List<MealEntity>>>(
          SuccessResult<List<MealEntity>>([]),
        );
        provideDummy<Result<dynamic>>(SuccessResult<void>(null));

        final meals = [
          MealEntity(idMeal: '1', strMeal: 'Cake', strMealThumb: null),
        ];
        when(
          mockMealsRepo.getMealsByCategory(category: categoryName),
        ).thenAnswer((_) async => SuccessResult(meals));

        final result = await getMealsUseCase.call(category: categoryName);

        expect(result, isA<SuccessResult<List<MealEntity>>>());
        expect((result as SuccessResult).data, meals);
        verify(
          mockMealsRepo.getMealsByCategory(category: categoryName),
        ).called(1);
      },
    );

    test(
      'returns FailureResult<List<MealEntity>> when repository fails',
      () async {
        provideDummy<Result<List<MealEntity>>>(
          SuccessResult<List<MealEntity>>([]),
        );
        provideDummy<Result<dynamic>>(SuccessResult<void>(null));

        final exception = Exception('Repo error');
        when(
          mockMealsRepo.getMealsByCategory(category: categoryName),
        ).thenAnswer((_) async => FailureResult<List<MealEntity>>(exception));

        final result = await getMealsUseCase.call(category: categoryName);

        expect(result, isA<FailureResult<List<MealEntity>>>());
        expect((result as FailureResult).exception, exception);
        verify(
          mockMealsRepo.getMealsByCategory(category: categoryName),
        ).called(1);
      },
    );
  });
}
