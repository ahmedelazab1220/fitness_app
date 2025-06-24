import 'package:injectable/injectable.dart';
import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/meal_details_entity.dart';
import '../repo/meal_details_repo.dart';

@injectable
class GetMealDetailsUseCase {
  final MealsRepo _mealsRepo;

  GetMealDetailsUseCase(this._mealsRepo);

  Future<Result<MealDetailsEntity>> call(String id) async {
    return await _mealsRepo.getMealDetails(id);
  }
}
