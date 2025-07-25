import '../../domain/meals/entity/meal_details_entity.dart';

extension MealDetailsEntityVideo on MealDetailsEntity {
  bool get hasYoutubeVideo =>
      strYoutube != null && strYoutube!.contains('http');
}

extension MealDetailsEntityNutrients on MealDetailsEntity {
  List<Map<String, String>> get nutrients {
    return [
      {'label': 'Energy', 'value': '100 K'}, // أو قيمة محسوبة
      {'label': 'Protein', 'value': '15 G'},
      {'label': 'Carbs', 'value': '58 G'},
      {'label': 'Fat', 'value': '20 G'},
    ];
  }
}
