class MealDetailsEntity {
  final String id;
  final String name;
  final String image;
  final String category;
  final String area;
  final String instructions;
  final List<String> ingredients;
  final List<String> measures;

  MealDetailsEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.area,
    required this.instructions,
    required this.ingredients,
    required this.measures,
  });
}
