import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/meal_details_entity.dart';

abstract interface class MealsRepo {
  Future<Result<MealDetailsEntity>> getMealDetails(String id);
}
