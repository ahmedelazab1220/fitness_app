import 'package:flutter/material.dart';
import 'nutrient_Info.dart';

class NutrientBody extends StatelessWidget {
  const NutrientBody({super.key, required this.nutrients});

  final List<Map<String, String>> nutrients;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: nutrients.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final nutrient = nutrients[index];
          return NutrientInfo(
            label: nutrient['label']!,
            value: nutrient['value']!,
          );
        },
      ),
    );
  }
}
