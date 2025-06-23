import 'package:fitness_app/data/meals/api/meals_retrofit_client.dart';
import 'package:fitness_app/data/meals/data_source/remote/meals_remote_data_source_impl.dart';
import 'package:fitness_app/data/meals/models/categories_dto.dart';
import 'package:fitness_app/data/meals/models/categories_response_dto.dart';
import 'package:fitness_app/data/meals/models/meals_dto.dart';
import 'package:fitness_app/data/meals/models/meals_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meals_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([MealsRetrofitClient])
void main() {
  late MealsRemoteDataSourceImpl mealsRemoteDataSourceImpl;
  late MockMealsRetrofitClient mockMealsRetrofitClient;

  setUp(() {
    mockMealsRetrofitClient = MockMealsRetrofitClient();
    mealsRemoteDataSourceImpl = MealsRemoteDataSourceImpl(
      mockMealsRetrofitClient,
    );
  });

  group("Meals Remote Data Source Test", () {
    group("getCategories", () {
      test("should return CategoriesResponseDto", () async {
        // Arrange
        final expectedResponse = CategoriesResponseDto(
          categories: [CategoriesDto(idCategory: '1', strCategory: 'Dessert')],
        );
        when(
          mockMealsRetrofitClient.getCategories(),
        ).thenAnswer((_) async => expectedResponse);

        // Act
        final result = await mealsRemoteDataSourceImpl.getCategories();

        // Assert
        verify(mockMealsRetrofitClient.getCategories()).called(1);
        expect(result, isA<CategoriesResponseDto>());
      });

      test("should throw exception when API fails", () {
        // Arrange
        final exception = Exception('API error');
        when(
          mockMealsRetrofitClient.getCategories(),
        ).thenAnswer((_) async => throw exception);

        // Act
        final result = mealsRemoteDataSourceImpl.getCategories();

        // Assert
        verify(mockMealsRetrofitClient.getCategories()).called(1);
        expect(result, throwsA(isA<Exception>()));
      });
    });

    group("getMealsByCategory", () {
      test("should return MealsResponseDto for given category", () async {
        // Arrange
        const category = 'Dessert';
        final expectedResponse = MealsResponseDto(
          meals: [MealsDto(idMeal: '1', strMeal: 'Cake')],
        );
        when(
          mockMealsRetrofitClient.getMealsByCategory(category: category),
        ).thenAnswer((_) async => expectedResponse);

        // Act
        final result = await mealsRemoteDataSourceImpl.getMealsByCategory(
          category: category,
        );

        // Assert
        verify(
          mockMealsRetrofitClient.getMealsByCategory(category: category),
        ).called(1);
        expect(result, isA<MealsResponseDto>());
      });

      test("should throw exception when API fails", () {
        // Arrange
        final exception = Exception('API error');
        const category = 'Dessert';
        when(
          mockMealsRetrofitClient.getMealsByCategory(category: category),
        ).thenAnswer((_) async => throw exception);

        // Act
        final result = mealsRemoteDataSourceImpl.getMealsByCategory(
          category: category,
        );

        // Assert
        verify(
          mockMealsRetrofitClient.getMealsByCategory(category: category),
        ).called(1);
        expect(result, throwsA(isA<Exception>()));
      });
    });
  });
}
