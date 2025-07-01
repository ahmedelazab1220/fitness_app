import '../../../data/meals/model/ingredient.dart';

class MealDetailsEntity {
  final String idMeal;
  final String strMeal;
  final String strCategory;
  final String strArea;
  final String strInstructions;
  final String strMealThumb;
  final String? strYoutube;
  final List<Ingredient> ingredients;

  MealDetailsEntity({
    required this.idMeal,
    required this.strMeal,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
    this.strYoutube,
    required this.ingredients,
  });
}

extension MealDetailsEntityVideo on MealDetailsEntity {
  bool get hasYoutubeVideo =>
      strYoutube != null && strYoutube!.contains('http');
}

extension MealDetailsEntityNutrients on MealDetailsEntity {
  List<Map<String, String>> get nutrients {
    return [
      {'label': 'Energy', 'value': '100 K'},
      {'label': 'Protein', 'value': '15 G'},
      {'label': 'Carbs', 'value': '58 G'},
      {'label': 'Fat', 'value': '20 G'},
    ];
  }
}
