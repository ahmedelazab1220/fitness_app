import 'package:fitness_app/features/details_food/presentation/view_model/cubit/meal_details_state.dart';
import 'package:fitness_app/features/details_food/presentation/view_model/cubit/meals_details_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/domain/meal/use_case/meal_details_use_case.dart';
import 'package:fitness_app/core/base/base_state.dart';
import 'package:fitness_app/domain/meal/entity/meal_details_entity.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';

class MockGetMealDetailsUseCase extends Mock implements GetMealDetailsUseCase {}

void main() {
  late MealDetailsCubit cubit;
  late MockGetMealDetailsUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetMealDetailsUseCase();
    cubit = MealDetailsCubit(mockUseCase, cubit.mealId);
  });

  const testId = '123';
  final testMeal = MealDetailsEntity(
    idMeal: '123',
    strMeal: 'Chicken',
    strCategory: 'Dinner',
    strArea: 'American',
    strInstructions: 'Cook it well',
    strMealThumb: 'img.jpg',
    strYoutube: 'https://youtube.com',
    ingredients: [],
  );

  test('✅ emits [Loading, Success] when use case returns success', () async {
    when(
      mockUseCase.call(testId),
    ).thenAnswer((_) async => SuccessResult(testMeal));

    final expected = [
      isA<MealDetailsState>().having(
        (s) => s.mealDetailsStatus,
        'Loading',
        isA<BaseLoadingState>(),
      ),
      isA<MealDetailsState>().having(
        (s) => s.mealDetailsStatus,
        'Success',
        isA<BaseSuccessState<MealDetailsEntity>>(),
      ),
    ];

    expectLater(cubit.stream, emitsInOrder(expected));

    await cubit.getMealDetails(testId);
    verify(mockUseCase.call(testId)).called(1);
  });

  test('❌ emits [Loading, Error] when use case returns failure', () async {
    final exception = Exception('Failed');
    when(
      mockUseCase.call(testId),
    ).thenAnswer((_) async => FailureResult(exception));

    final expected = [
      isA<MealDetailsState>().having(
        (s) => s.mealDetailsStatus,
        'Loading',
        isA<BaseLoadingState>(),
      ),
      isA<MealDetailsState>().having(
        (s) => s.mealDetailsStatus,
        'Error',
        isA<BaseErrorState>(),
      ),
    ];

    expectLater(cubit.stream, emitsInOrder(expected));

    await cubit.getMealDetails(testId);
    verify(mockUseCase.call(testId)).called(1);
  });
}
