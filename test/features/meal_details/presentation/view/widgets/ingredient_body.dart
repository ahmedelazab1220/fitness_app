import 'package:fitness_app/domain/meal/entity/meal_details_entity.dart';
import 'package:fitness_app/features/details_food/presentation/view/widgets/ingredient_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_localization/easy_localization.dart';

void main() {
  testWidgets('🧪 renders IngredientBody with ingredients', (
    WidgetTester tester,
  ) async {
    // Arrange
    final meal = MealDetailsEntity(
      idMeal: '123',
      strMeal: 'Test Meal',
      strCategory: 'Category',
      strArea: 'Area',
      strInstructions: 'Cook well',
      strMealThumb: 'https://img.jpg',
      strYoutube: 'https://youtube.com',
      ingredients: [
        Ingredient(name: 'Chicken', measure: '200g'),
        Ingredient(name: 'Rice', measure: '100g'),
      ],
    );

    // Act
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        child: MaterialApp(
          home: IngredientBody(theme: ThemeData.light(), meal: meal),
        ),
      ),
    );

    // Assert
    expect(
      find.text('Ingredients'),
      findsOneWidget,
    ); // or LocaleKeys.Ingredients.tr() if initialized
    expect(find.text('Chicken'), findsOneWidget);
    expect(find.text('200g'), findsOneWidget);
    expect(find.text('Rice'), findsOneWidget);
    expect(find.text('100g'), findsOneWidget);
  });

  testWidgets('🧪 renders nothing when ingredients are empty', (
    WidgetTester tester,
  ) async {
    final meal = MealDetailsEntity(
      idMeal: '123',
      strMeal: 'Empty Meal',
      strCategory: 'Cat',
      strArea: 'Area',
      strInstructions: 'None',
      strMealThumb: '',
      strYoutube: null,
      ingredients: [],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: IngredientBody(theme: ThemeData.light(), meal: meal),
      ),
    );

    expect(find.byType(IngredientBody), findsOneWidget);
    expect(find.byType(Text), findsNothing);
    expect(find.byType(ListView), findsNothing);
  });
}
