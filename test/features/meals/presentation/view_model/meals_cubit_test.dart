import 'package:fitness_app/domain/meals/use_case/get_categories_use_case.dart';
import 'package:fitness_app/domain/meals/use_case/get_meals_by_category_use_case.dart';
import 'package:fitness_app/features/meals/presentation/view_model/meals_cubit.dart';
import 'package:fitness_app/features/meals/presentation/view_model/meals_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/core/base/base_state.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/domain/meals/entity/category_entity.dart';
import 'package:fitness_app/domain/meals/entity/meal_entity.dart';

import 'meals_cubit_test.mocks.dart';

@GenerateMocks([GetCategoriesUseCase, GetMealsByCategoryUseCase])
void main() {
  late MockGetCategoriesUseCase mockGetCategoriesUseCase;
  late MockGetMealsByCategoryUseCase mockGetMealsByCategoryUseCase;
  late MealsCubit mealsCubit;

  setUp(() {
    mockGetCategoriesUseCase = MockGetCategoriesUseCase();
    mockGetMealsByCategoryUseCase = MockGetMealsByCategoryUseCase();
    mealsCubit = MealsCubit(
      mockGetCategoriesUseCase,
      mockGetMealsByCategoryUseCase,
    );
  });

  tearDown(() => mealsCubit.close());

  test('initial state has BaseInitialState for both categories and meals', () {
    expect(mealsCubit.state.categoriesState, isA<BaseInitialState>());
    expect(mealsCubit.state.mealsState, isA<BaseInitialState>());
  });

  group('GetCategoriesAction', () {
    test('emits loading then success on usecase success', () async {
      provideDummy<Result<List<CategoryEntity>>>(
        SuccessResult<List<CategoryEntity>>([]),
      );
      provideDummy<Result<dynamic>>(SuccessResult<void>(null));

      final categories = [
        CategoryEntity(idCategory: '1', strCategory: 'Dessert'),
      ];
      when(
        mockGetCategoriesUseCase(),
      ).thenAnswer((_) async => SuccessResult(categories));

      final expected = [
        predicate<MealsState>(
          (state) => state.categoriesState is BaseLoadingState,
        ),
        predicate<MealsState>(
          (state) =>
              state.categoriesState is BaseSuccessState &&
              (state.categoriesState as BaseSuccessState).data == categories,
        ),
      ];
      expectLater(mealsCubit.stream, emitsInOrder(expected));

      mealsCubit.doIntent(GetCategoriesAction());
    });

    test('emits loading then error on usecase failure', () async {
      provideDummy<Result<List<CategoryEntity>>>(
        SuccessResult<List<CategoryEntity>>([]),
      );
      provideDummy<Result<dynamic>>(SuccessResult<void>(null));

      final exception = Exception('Repo error');
      when(
        mockGetCategoriesUseCase(),
      ).thenAnswer((_) async => FailureResult<List<CategoryEntity>>(exception));

      final expected = [
        predicate<MealsState>(
          (state) => state.categoriesState is BaseLoadingState,
        ),
        predicate<MealsState>(
          (state) =>
              state.categoriesState is BaseErrorState &&
              (state.categoriesState as BaseErrorState).errorMessage.contains(
                'Exception',
              ),
        ),
      ];
      expectLater(mealsCubit.stream, emitsInOrder(expected));

      mealsCubit.doIntent(GetCategoriesAction());
    });
  });

  group('GetMealsAction', () {
    const categoryName = 'Dessert';

    test('emits loading then success on usecase success', () async {
      provideDummy<Result<List<MealEntity>>>(
        SuccessResult<List<MealEntity>>([]),
      );
      provideDummy<Result<dynamic>>(SuccessResult<void>(null));

      final meals = [
        MealEntity(idMeal: '1', strMeal: 'Cake', strMealThumb: null),
      ];
      when(
        mockGetMealsByCategoryUseCase(category: categoryName),
      ).thenAnswer((_) async => SuccessResult(meals));

      final expected = [
        predicate<MealsState>((state) => state.mealsState is BaseLoadingState),
        predicate<MealsState>(
          (state) =>
              state.mealsState is BaseSuccessState &&
              (state.mealsState as BaseSuccessState).data == meals,
        ),
      ];
      expectLater(mealsCubit.stream, emitsInOrder(expected));

      mealsCubit.doIntent(GetMealsAction(categoryName));
    });

    test('emits loading then error on usecase failure', () async {
      provideDummy<Result<List<MealEntity>>>(
        SuccessResult<List<MealEntity>>([]),
      );
      provideDummy<Result<dynamic>>(SuccessResult<void>(null));

      final exception = Exception('Repo error');
      when(
        mockGetMealsByCategoryUseCase(category: categoryName),
      ).thenAnswer((_) async => FailureResult<List<MealEntity>>(exception));

      final expected = [
        predicate<MealsState>((state) => state.mealsState is BaseLoadingState),
        predicate<MealsState>(
          (state) =>
              state.mealsState is BaseErrorState &&
              (state.mealsState as BaseErrorState).errorMessage.contains(
                'Exception',
              ),
        ),
      ];
      expectLater(mealsCubit.stream, emitsInOrder(expected));

      mealsCubit.doIntent(GetMealsAction(categoryName));
    });
  });

  // test(
  //   'SelectCategoryAction triggers getMeals and updates selectedCategoryIndex',
  //   () async {
  //     provideDummy<Result<List<CategoryEntity>>>(
  //       SuccessResult<List<CategoryEntity>>([]),
  //     );
  //     provideDummy<Result<dynamic>>(SuccessResult<void>(null));
  //     provideDummy<Result<List<MealEntity>>>(
  //       SuccessResult<List<MealEntity>>([]),
  //     );
  //
  //     // stub initial categories
  //     final categories = [
  //       CategoryEntity(idCategory: '1', strCategory: 'Dessert'),
  //     ];
  //     when(
  //       mockGetCategoriesUseCase(),
  //     ).thenAnswer((_) async => SuccessResult(categories));
  //     // stub meals fetch
  //     final meals = [
  //       MealEntity(idMeal: '1', strMeal: 'Cake', strMealThumb: null),
  //     ];
  //     when(
  //       mockGetMealsByCategoryUseCase(category: 'Dessert'),
  //     ).thenAnswer((_) async => SuccessResult(meals));
  //
  //     final expected = <dynamic>[
  //       // categories load
  //       predicate<MealsState>(
  //         (state) => state.categoriesState is BaseLoadingState,
  //       ),
  //       predicate<MealsState>(
  //         (state) => state.categoriesState is BaseSuccessState,
  //       ),
  //       // on select
  //       predicate<MealsState>(
  //         (state) => state.mealsState is BaseLoadingState,
  //       ),
  //       predicate<MealsState>(
  //         (state) => state.mealsState is BaseSuccessState,
  //       ),
  //       predicate<MealsState>(
  //         (state) => state.selectedCategoryIndex == 0,
  //       ),
  //     ];
  //     expectLater(mealsCubit.stream, emitsInOrder(expected));
  //
  //     mealsCubit.doIntent(GetCategoriesAction());
  //     await untilCalled(mockGetCategoriesUseCase());
  //     mealsCubit.doIntent(SelectCategoryAction(0));
  //   },
  // );
}
