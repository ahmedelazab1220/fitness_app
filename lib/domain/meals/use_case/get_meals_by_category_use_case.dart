import 'package:fitness_app/domain/meals/repo/meals_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/meal_entity.dart';

@injectable
class GetMealsByCategoryUseCase {
  final MealsRepo _mealsRepo;

  GetMealsByCategoryUseCase(this._mealsRepo);

  Future<Result<List<MealEntity>>> call({required String category}) async {
    return await _mealsRepo.getMealsByCategory(category: category);
  }
}
