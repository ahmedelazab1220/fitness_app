import 'package:fitness_app/features/meal_details/presentation/view/widgets/nutrient_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_app/core/assets/app_colors.dart';

void main() {
  testWidgets('NutrientInfo displays value and label correctly', (
    WidgetTester tester,
  ) async {
    // Arrange
    const testValue = '25g';
    const testLabel = 'Carbs';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          body: NutrientInfo(value: testValue, label: testLabel),
        ),
      ),
    );

    // Assert
    expect(find.text(testValue), findsOneWidget);
    expect(find.text(testLabel), findsOneWidget);

    final valueText = tester.widget<Text>(find.text(testValue));
    final labelText = tester.widget<Text>(find.text(testLabel));

    // Check color style
    expect((valueText.style?.color), Colors.white);
    expect((labelText.style?.color), AppColors.orange);
  });
}
