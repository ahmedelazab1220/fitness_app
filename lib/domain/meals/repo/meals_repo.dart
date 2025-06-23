import 'package:fitness_app/domain/meals/entity/category_entity.dart';
import 'package:fitness_app/domain/meals/entity/meal_entity.dart';

import '../../../core/utils/datasource_excution/api_result.dart';

abstract class MealsRepo {
  Future<Result<List<CategoryEntity>>> getCategories();

  Future<Result<List<MealEntity>>> getMealsByCategory({
    required String category,
  });
}
