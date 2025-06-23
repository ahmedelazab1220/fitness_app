import 'package:fitness_app/data/meals/repo_impl/meals_repo_impl.dart';
import 'package:fitness_app/domain/meals/entity/category_entity.dart';
import 'package:fitness_app/domain/meals/entity/meal_entity.dart';
import 'package:fitness_app/data/meals/data_source/contract/meals_remote_data_source.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_manager.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
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
        // Register dummy for generics
        provideDummy<Result<List<CategoryEntity>>>(
          SuccessResult<List<CategoryEntity>>([]),
        );
        provideDummy<Result<dynamic>>(SuccessResult<void>(null));

        // Prepare expected data
        final expectedEntities = [
          CategoryEntity(idCategory: '1', strCategory: 'Dessert'),
        ];

        // Stub ApiManager to return success
        when(mockApiManager.execute<List<CategoryEntity>>(any)).thenAnswer(
          (_) async => SuccessResult<List<CategoryEntity>>(expectedEntities),
        );

        // Act
        final result = await mealsRepo.getCategories();

        // Assert
        expect(result, isA<SuccessResult<List<CategoryEntity>>>());
        expect((result as SuccessResult).data, expectedEntities);
        verify(mockApiManager.execute<List<CategoryEntity>>(any)).called(1);
      });

      test('returns FailureResult<List<CategoryEntity>> on failure', () async {
        // Register dummy for generics
        provideDummy<Result<List<CategoryEntity>>>(
          SuccessResult<List<CategoryEntity>>([]),
        );
        provideDummy<Result<dynamic>>(SuccessResult<void>(null));

        final error = Exception('API error');

        // Stub ApiManager to return failure
        when(
          mockApiManager.execute<List<CategoryEntity>>(any),
        ).thenAnswer((_) async => FailureResult<List<CategoryEntity>>(error));

        // Act
        final result = await mealsRepo.getCategories();

        // Assert
        expect(result, isA<FailureResult<List<CategoryEntity>>>());
        expect((result as FailureResult).exception, error);
        verify(mockApiManager.execute<List<CategoryEntity>>(any)).called(1);
      });
    });

    group('getMealsByCategory', () {
      const categoryName = 'Dessert';

      test('returns SuccessResult<List<MealEntity>> on success', () async {
        // Register dummy for generics
        provideDummy<Result<List<MealEntity>>>(
          SuccessResult<List<MealEntity>>([]),
        );
        provideDummy<Result<dynamic>>(SuccessResult<void>(null));

        // Prepare expected data
        final expectedMeals = [MealEntity(idMeal: '1', strMeal: 'Cake')];

        // Stub ApiManager to return success
        when(mockApiManager.execute<List<MealEntity>>(any)).thenAnswer(
          (_) async => SuccessResult<List<MealEntity>>(expectedMeals),
        );

        // Act
        final result = await mealsRepo.getMealsByCategory(
          category: categoryName,
        );

        // Assert
        expect(result, isA<SuccessResult<List<MealEntity>>>());
        expect((result as SuccessResult).data, expectedMeals);
        verify(mockApiManager.execute<List<MealEntity>>(any)).called(1);
      });

      test('returns FailureResult<List<MealEntity>> on failure', () async {
        // Register dummy for generics
        provideDummy<Result<List<MealEntity>>>(
          SuccessResult<List<MealEntity>>([]),
        );
        provideDummy<Result<dynamic>>(SuccessResult<void>(null));

        final error = Exception('API error');

        // Stub ApiManager to return failure
        when(
          mockApiManager.execute<List<MealEntity>>(any),
        ).thenAnswer((_) async => FailureResult<List<MealEntity>>(error));

        // Act
        final result = await mealsRepo.getMealsByCategory(
          category: categoryName,
        );

        // Assert
        expect(result, isA<FailureResult<List<MealEntity>>>());
        expect((result as FailureResult).exception, error);
        verify(mockApiManager.execute<List<MealEntity>>(any)).called(1);
      });
    });
  });
}
