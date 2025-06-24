import 'package:fitness_app/features/details_food/presentation/view/widgets/ingredient_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('🧪 IngredientItem renders name and amount correctly', (
    WidgetTester tester,
  ) async {
    // Arrange
    const name = 'Chicken';
    const amount = '200g';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: IngredientItem(name: name, amount: amount),
        ),
      ),
    );

    // Assert
    expect(find.text(name), findsOneWidget);
    expect(find.text(amount), findsOneWidget);
    expect(find.byType(Divider), findsOneWidget);
    expect(
      tester.widget<Text>(find.text(amount)).style?.color,
      equals(const Color(0xFFFF7F3F)),
    );
  });
}
