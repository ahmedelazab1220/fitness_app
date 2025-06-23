import 'package:fitness_app/data/meal/api/meals_retrofit_client.dart';
import 'package:fitness_app/data/meal/data_source/remote/meal_details_remote_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_app/data/meal/model/meal_details_response_dto.dart';
import 'package:mockito/mockito.dart';

class MockMealsRetrofitClient extends Mock implements MealsRetrofitClient {}

void main() {
  late MealsRemoteDataSourceImpl dataSource;
  late MockMealsRetrofitClient mockClient;

  setUp(() {
    mockClient = MockMealsRetrofitClient();
    dataSource = MealsRemoteDataSourceImpl(mockClient);
  });

  group('MealsRemoteDataSourceImpl', () {
    test('returns MealDetailsResponseDto from client', () async {
      // arrange
      const mealId = '12345';
      final expectedDto = MealDetailsResponseDto(
        meals: [
          MealDetailsDto(
            idMeal: '12345',
            strMeal: 'Pasta',
            strInstructions: 'Cook it',
            strMealThumb: 'https://image.jpg',
            strYoutube: 'https://youtube.com/test',
            strCategory: 'Italian',
            strArea: 'Italy',
            strIngredient1: 'Tomato',
            strMeasure1: '1 cup',
            strIngredient2: '',
            strIngredient3: '',
            strIngredient4: '',
            strIngredient5: '',
            strIngredient6: '',
            strIngredient7: '',
            strIngredient8: '',
            strIngredient9: '',
            strIngredient10: '',
            strIngredient11: '',
            strIngredient12: '',
            strIngredient13: '',
            strIngredient14: '',
            strIngredient15: '',
            strIngredient16: '',
            strIngredient17: '',
            strIngredient18: '',
            strIngredient19: '',
            strIngredient20: '',
            strMeasure2: '',
            strMeasure3: '',
            strMeasure4: '',
            strMeasure5: '',
            strMeasure6: '',
            strMeasure7: '',
            strMeasure8: '',
            strMeasure9: '',
            strMeasure10: '',
            strMeasure11: '',
            strMeasure12: '',
            strMeasure13: '',
            strMeasure14: '',
            strMeasure15: '',
            strMeasure16: '',
            strMeasure17: '',
            strMeasure18: '',
            strMeasure19: '',
            strMeasure20: '',
          ),
        ],
      );

      when(
        mockClient.getMealDetails(mealId),
      ).thenAnswer((_) async => expectedDto);

      // act
      final result = await dataSource.getMealDetails(mealId);

      // assert
      expect(result, expectedDto);
      verify(mockClient.getMealDetails(mealId)).called(1);
    });
  });
}
