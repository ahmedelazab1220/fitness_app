import 'package:fitness_app/core/utils/datasource_excution/api_manager.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/data/meals/data_source/contract/meals_remote_data_source.dart';
import 'package:fitness_app/data/meals/models/categories_dto.dart';
import 'package:fitness_app/data/meals/models/categories_response_dto.dart';
import 'package:fitness_app/data/meals/models/meals_dto.dart';
import 'package:fitness_app/data/meals/models/meals_response_dto.dart';
import 'package:fitness_app/data/meals/repo_impl/meals_repo_impl.dart';
import 'package:fitness_app/domain/meals/entity/category_entity.dart';
import 'package:fitness_app/domain/meals/entity/meal_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meals_repo_impl_test.mocks.dart';

@GenerateMocks([ApiManager, MealsRemoteDataSource])
void main() {
  late MealsRepoImpl mealsRepo;
  late MockMealsRemoteDataSource mockRemote;
  late MockApiManager mockApiManager;

  setUp(() {
    mockRemote = MockMealsRemoteDataSource();
    mockApiManager = MockApiManager();
    mealsRepo = MealsRepoImpl(mockRemote, mockApiManager);
  });

  group('MealsRepoImpl Tests', () {
    group('getCategories', () {
      test('returns SuccessResult<List<CategoryEntity>> on success', () async {
        // prepare dto & expected data
        final categoriesDto = CategoriesResponseDto(
          categories: [CategoriesDto(idCategory: '1', strCategory: 'Dessert')],
        );
        final expectedEntities = [
          CategoryEntity(idCategory: '1', strCategory: 'Dessert'),
        ];

        // Register dummy for generics
        provideDummy<Result<List<CategoryEntity>>>(
          SuccessResult<List<CategoryEntity>>(expectedEntities),
        );

        // Stub ApiManager to return success
        when(mockApiManager.execute<List<CategoryEntity>>(any)).thenAnswer(
          (_) async => SuccessResult<List<CategoryEntity>>(expectedEntities),
        );

        // Stub Remote Data Source to return expected data
        when(mockRemote.getCategories()).thenAnswer((_) async => categoriesDto);

        // Act
        final result = await mealsRepo.getCategories();

        // Assert
        verify(mockApiManager.execute<List<CategoryEntity>>(any)).called(1);
        expect(result, isA<SuccessResult<List<CategoryEntity>>>());
      });

      test('returns FailureResult<List<CategoryEntity>> on failure', () async {
        // Register dummy for generics
        final error = Exception('API error');

        provideDummy<Result<List<CategoryEntity>>>(
          FailureResult<List<CategoryEntity>>(error),
        );
        // prepare dto & expected data
        final categoriesDto = CategoriesResponseDto(
          categories: [CategoriesDto(idCategory: '1', strCategory: 'Dessert')],
        );
        final expectedEntities = [
          CategoryEntity(idCategory: '1', strCategory: 'Dessert'),
        ];

        // Stub ApiManager to return failure
        when(
          mockApiManager.execute<List<CategoryEntity>>(any),
        ).thenAnswer((_) async => FailureResult<List<CategoryEntity>>(error));

        // Stub Remote Data Source to return expected data
        when(mockRemote.getCategories()).thenAnswer((_) async => categoriesDto);

        // Act
        final result = await mealsRepo.getCategories();

        // Assert
        verify(mockApiManager.execute<List<CategoryEntity>>(any)).called(1);
        expect(result, isA<FailureResult<List<CategoryEntity>>>());
      });
    });

    group('getMealsByCategory', () {
      const categoryName = 'Dessert';

      test('returns SuccessResult<List<MealEntity>> on success', () async {
        // Prepare dto & expected data
        final mealsDto = MealsResponseDto(
          meals: [MealsDto(idMeal: '1', strMeal: 'Cake')],
        );
        final expectedMeals = [MealEntity(idMeal: '1', strMeal: 'Cake')];

        // Register dummy for generics
        provideDummy<Result<List<MealEntity>>>(
          SuccessResult<List<MealEntity>>(expectedMeals),
        );

        // Stub ApiManager to return success
        when(mockApiManager.execute<List<MealEntity>>(any)).thenAnswer(
          (_) async => SuccessResult<List<MealEntity>>(expectedMeals),
        );

        // Stub Remote Data Source to return expected data
        when(
          mockRemote.getMealsByCategory(category: categoryName),
        ).thenAnswer((_) async => mealsDto);

        // Act
        final result = await mealsRepo.getMealsByCategory(
          category: categoryName,
        );

        // Assert
        verify(mockApiManager.execute<List<MealEntity>>(any)).called(1);
        expect(result, isA<SuccessResult<List<MealEntity>>>());
      });

      test('returns FailureResult<List<MealEntity>> on failure', () async {
        final error = Exception('API error');

        // Register dummy for generics
        provideDummy<Result<List<MealEntity>>>(
          FailureResult<List<MealEntity>>(error),
        );

        // Prepare dto & expected data
        final mealsDto = MealsResponseDto(
          meals: [MealsDto(idMeal: '1', strMeal: 'Cake')],
        );
        final expectedMeals = [MealEntity(idMeal: '1', strMeal: 'Cake')];

        // Stub ApiManager to return failure
        when(
          mockApiManager.execute<List<MealEntity>>(any),
        ).thenAnswer((_) async => FailureResult<List<MealEntity>>(error));

        // Stub Remote Data Source to return expected data
        when(
          mockRemote.getMealsByCategory(category: categoryName),
        ).thenAnswer((_) async => mealsDto);

        // Act
        final result = await mealsRepo.getMealsByCategory(
          category: categoryName,
        );

        // Assert
        verify(mockApiManager.execute<List<MealEntity>>(any)).called(1);
        expect(result, isA<FailureResult<List<MealEntity>>>());
      });
    });
  });
}
