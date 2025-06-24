import 'package:fitness_app/features/details_food/presentation/view/widgets/nutrient_body.dart';
import 'package:fitness_app/features/details_food/presentation/view/widgets/nutrient_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('NutrientBody displays all nutrients correctly', (
    WidgetTester tester,
  ) async {
    final testNutrients = [
      {'label': 'Carbs', 'value': '30g'},
      {'label': 'Protein', 'value': '20g'},
      {'label': 'Fat', 'value': '10g'},
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: NutrientBody(nutrients: testNutrients)),
      ),
    );

    expect(find.byType(NutrientInfo), findsNWidgets(3));
    expect(find.text('Carbs'), findsOneWidget);
    expect(find.text('30g'), findsOneWidget);
    expect(find.text('Protein'), findsOneWidget);
    expect(find.text('Fat'), findsOneWidget);
  });
}
