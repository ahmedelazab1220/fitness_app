import 'package:fitness_app/domain/meals/use_case/get_categories_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/domain/meals/entity/category_entity.dart';
import 'package:fitness_app/domain/meals/repo/meals_repo.dart';

import 'get_categories_use_case_test.mocks.dart';

@GenerateMocks([MealsRepo])
void main() {
  late MockMealsRepo mockMealsRepo;
  late GetCategoriesUseCase getCategoriesUseCase;

  setUp(() {
    mockMealsRepo = MockMealsRepo();
    getCategoriesUseCase = GetCategoriesUseCase(mockMealsRepo);
  });

  group('GetCategoriesUseCase', () {
    test(
      'returns SuccessResult<List<CategoryEntity>> when repository succeeds',
      () async {
        provideDummy<Result<List<CategoryEntity>>>(
          SuccessResult<List<CategoryEntity>>([]),
        );
        provideDummy<Result<dynamic>>(SuccessResult<void>(null));

        final categories = [
          CategoryEntity(idCategory: '1', strCategory: 'Dessert'),
        ];
        when(
          mockMealsRepo.getCategories(),
        ).thenAnswer((_) async => SuccessResult(categories));

        final result = await getCategoriesUseCase.call();

        expect(result, isA<SuccessResult<List<CategoryEntity>>>());
        expect((result as SuccessResult).data, categories);
        verify(mockMealsRepo.getCategories()).called(1);
      },
    );

    test(
      'returns FailureResult<List<CategoryEntity>> when repository fails',
      () async {
        provideDummy<Result<List<CategoryEntity>>>(
          SuccessResult<List<CategoryEntity>>([]),
        );
        provideDummy<Result<dynamic>>(SuccessResult<void>(null));

        final exception = Exception('Repo error');
        when(mockMealsRepo.getCategories()).thenAnswer(
          (_) async => FailureResult<List<CategoryEntity>>(exception),
        );

        final result = await getCategoriesUseCase.call();

        expect(result, isA<FailureResult<List<CategoryEntity>>>());
        expect((result as FailureResult).exception, exception);
        verify(mockMealsRepo.getCategories()).called(1);
      },
    );
  });
}
