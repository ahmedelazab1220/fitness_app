import 'package:dio/dio.dart';
import 'package:fitness_app/data/meal/api/meals_retrofit_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late MealsRetrofitClient client;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'https://www.themealdb.com/api/json/v1/1/'));
    dioAdapter = DioAdapter(dio: dio);
    client = MealsRetrofitClient(dio);
  });

  test('getMealDetails returns correct MealDetailsResponseDto', () async {
    // Arrange
    const id = '52772';
    final responsePayload = {
      "meals": [
        {
          "idMeal": "52772",
          "strMeal": "Spicy Arrabiata Penne",
          "strInstructions": "Bring a large pot of water to a boil...",
          "strMealThumb":
              "https://www.themealdb.com/images/media/meals/ustsqw1468250014.jpg",
          "strYoutube": "https://www.youtube.com/watch?v=1IszT_guI08",
          "strCategory": "Pasta",
          "strArea": "Italian",
          "strIngredient1": "Penne Rigate",
          "strMeasure1": "1 pound",
            List.generate(19, (i) => MapEntry('strIngredient${i + 2}', '')),
          ),
          ...Map.fromEntries(
            List.generate(19, (i) => MapEntry('strMeasure${i + 2}', '')),
          ),
        },
      ],
    };

    dioAdapter.onGet(
      '/lookup.php',
      (server) => server.reply(200, responsePayload),
      queryParameters: {"i": id},
    );

    // Act
    final result = await client.getMealDetails(id);

    // Assert
    expect(result.meals.first.idMeal, equals('52772'));
    expect(result.meals.first.strMeal, contains('Arrabiata'));
  });
}
