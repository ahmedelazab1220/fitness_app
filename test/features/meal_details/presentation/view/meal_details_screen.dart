import 'package:fitness_app/core/base/base_state.dart';
import 'package:fitness_app/domain/meal/entity/meal_details_entity.dart';
import 'package:fitness_app/features/meal_details/presentation/view/meal_details_screen.dart';
import 'package:fitness_app/features/meal_details/presentation/view_model/cubit/meal_details_state.dart';
import 'package:fitness_app/features/meal_details/presentation/view_model/cubit/meals_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMealDetailsCubit extends Mock implements MealDetailsCubit {}

void main() {
  late MockMealDetailsCubit mockCubit;

  setUpAll(() {
    registerFallbackValue(
      MealDetailsState(mealDetailsStatus: BaseInitialState()),
    );
  });

  setUp(() {
    mockCubit = MockMealDetailsCubit();
  });

  Widget createTestableWidget() {
    return MaterialApp(
      home: BlocProvider<MealDetailsCubit>(
        create: (_) => mockCubit,
        child: const MealDetailsScreen(mealId: '123'),
      ),
    );
  }

  testWidgets('🔄 shows loading indicator', (WidgetTester tester) async {
    when(
      () => mockCubit.state,
    ).thenReturn(MealDetailsState(mealDetailsStatus: BaseLoadingState()));
    when(() => mockCubit.getMealDetails(any())).thenAnswer((_) async {});

    await tester.pumpWidget(createTestableWidget());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('❌ shows error message', (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(
      MealDetailsState(
        mealDetailsStatus: BaseErrorState(errorMessage: 'Something went wrong'),
      ),
    );
    when(() => mockCubit.getMealDetails(any())).thenAnswer((_) async {});

    await tester.pumpWidget(createTestableWidget());

    expect(find.text('Something went wrong'), findsOneWidget);
  });

  testWidgets('✅ shows meal details content', (WidgetTester tester) async {
    final meal = MealDetailsEntity(
      idMeal: '123',
      strMeal: 'Chicken Pasta',
      strCategory: 'Dinner',
      strArea: 'Italian',
      strInstructions: 'Boil pasta and mix with chicken.',
      strMealThumb: 'https://image.url',
      strYoutube: 'https://youtube.com/video',
      ingredients: [
        Ingredient(name: 'Pasta', measure: '200g'),
        Ingredient(name: 'Chicken', measure: '150g'),
      ],
    );

    when(() => mockCubit.state).thenReturn(
      MealDetailsState(mealDetailsStatus: BaseSuccessState(data: meal)),
    );
    when(() => mockCubit.getMealDetails(any())).thenAnswer((_) async {});

    await tester.pumpWidget(createTestableWidget());
    await tester.pumpAndSettle();

    expect(find.text('Chicken Pasta'), findsOneWidget);
    expect(find.textContaining('Boil pasta'), findsOneWidget);
    expect(find.text('Pasta'), findsOneWidget);
    expect(find.text('200g'), findsOneWidget);
    expect(find.text('Chicken'), findsOneWidget);
    expect(find.text('150g'), findsOneWidget);
  });
}
