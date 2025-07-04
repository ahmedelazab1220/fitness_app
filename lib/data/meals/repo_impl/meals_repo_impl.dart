import 'package:fitness_app/core/utils/datasource_excution/api_manager.dart';
import 'package:fitness_app/domain/meals/entity/category_entity.dart';
import 'package:fitness_app/domain/meals/entity/meal_entity.dart';
import 'package:fitness_app/domain/meals/repo/meals_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../data_source/contract/meals_remote_data_source.dart';

@Injectable(as: MealsRepo)
class MealsRepoImpl implements MealsRepo {
  final MealsRemoteDataSource _mealsRemoteDataSource;
  final ApiManager _apiManager;

  MealsRepoImpl(this._mealsRemoteDataSource, this._apiManager);

  @override
  Future<Result<List<CategoryEntity>>> getCategories() async {
    final result = await _apiManager.execute<List<CategoryEntity>>(() async {
      final response = await _mealsRemoteDataSource.getCategories();
      return response.categories!
          .map((category) => category.toEntity())
          .toList();
    });
    return result;
  }

  @override
  Future<Result<List<MealEntity>>> getMealsByCategory({
    required String category,
  }) async {
    final result = await _apiManager.execute<List<MealEntity>>(() async {
      final response = await _mealsRemoteDataSource.getMealsByCategory(
        category: category,
      );
      return response.meals!.map((meal) => meal.toEntity()).toList();
    });
    return result;
  }
}
