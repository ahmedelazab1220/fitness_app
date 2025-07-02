import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/meal_entity.dart';
import '../repo/home_repo.dart';

@injectable
class GetFoodRecommendationUseCase {
  final HomeRepo _homeRepo;

  GetFoodRecommendationUseCase(this._homeRepo);

  Future<Result<List<MealEntity>>> call() async =>
      await _homeRepo.getFoodRecommendation();
}
