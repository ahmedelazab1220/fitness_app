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
