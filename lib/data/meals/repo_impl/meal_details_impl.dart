import 'package:fitness_app/core/utils/datasource_excution/api_manager.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/meals/entity/meal_details_entity.dart';
import '../../../domain/meals/repo/meal_details_repo.dart';
import '../data_source/contract/meal_details_remote_data_source.dart';

@Injectable(as: MealsRepo)
class MealsRepoImpl implements MealsRepo {
  final MealsRemoteDataSource _mealsRemoteDataSource;
  final ApiManager _apiManager;

  MealsRepoImpl(this._mealsRemoteDataSource, this._apiManager);

  @override
  Future<Result<MealDetailsEntity>> getMealDetails(String id) async {
    return _apiManager.execute(() async {
      final response = await _mealsRemoteDataSource.getMealDetails(id);
      return response.meals.first.toEntity();
    });
  }
}
