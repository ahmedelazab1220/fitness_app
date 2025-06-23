import 'package:fitness_app/domain/meal/use_case/meal_details_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:fitness_app/domain/meal/repo/meal_details_repo.dart';
import 'package:fitness_app/domain/meal/entity/meal_details_entity.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';

class MockMealsRepo extends Mock implements MealsRepo {}

void main() {
  late GetMealDetailsUseCase useCase;
  late MockMealsRepo mockRepo;

  setUp(() {
    mockRepo = MockMealsRepo();
    useCase = GetMealDetailsUseCase(mockRepo);
  });

  test('should return SuccessResult with MealDetailsEntity', () async {
    // arrange
    const mealId = '123';
    final entity = MealDetailsEntity(
      idMeal: mealId,
      strMeal: 'Test Meal',
      strCategory: 'Category',
      strArea: 'Area',
      strInstructions: 'Instructions',
      strMealThumb: 'https://image.jpg',
      strYoutube: 'https://youtube.com',
      ingredients: [Ingredient(name: 'Rice', measure: '200g')],
    );

    when(
      mockRepo.getMealDetails(mealId),
    ).thenAnswer((_) async => SuccessResult(entity));

    // act
    final result = await useCase.call(mealId);

    // assert
    expect(result, isA<SuccessResult<MealDetailsEntity>>());
    expect((result as SuccessResult).data, entity);
    verify(mockRepo.getMealDetails(mealId)).called(1);
  });

  test('should return FailureResult when repository throws', () async {
    // arrange
    const mealId = '123';
    final exception = Exception('Something went wrong');

    when(
      mockRepo.getMealDetails(mealId),
    ).thenAnswer((_) async => FailureResult(exception));

    // act
    final result = await useCase.call(mealId);

    // assert
    expect(result, isA<FailureResult<MealDetailsEntity>>());
    expect((result as FailureResult).exception, exception);
    verify(mockRepo.getMealDetails(mealId)).called(1);
  });
}
