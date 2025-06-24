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

class Ingredient {
  final String name;
  final String measure;

  Ingredient({required this.name, required this.measure});
}

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

