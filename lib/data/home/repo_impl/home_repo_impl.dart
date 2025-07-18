import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_manager.dart';
import '../../../core/utils/datasource_excution/api_result.dart';
import '../../../domain/home/entity/category_entity.dart';
import '../../../domain/home/entity/meal_entity.dart';
import '../../../domain/home/entity/exercise_entity.dart';
import '../../../domain/home/entity/muscle_entity.dart';
import '../../../domain/home/entity/muscle_group_entity.dart';
import '../../../domain/home/repo/home_repo.dart';
import '../data_source/contract/home_local_data_source.dart';
import '../data_source/contract/home_remote_data_source.dart';

@Injectable(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource _homeRemoteDataSource;
  final HomeLocalDataSource _homeLocalDataSource;
  final ApiManager _apiManager;

  HomeRepoImpl(
    this._homeRemoteDataSource,
    this._homeLocalDataSource,
    this._apiManager,
  );

  @override
  Future<Result<List<ExerciseEntity>>> getDailyRecommendationExercise(
    int limit,
    String targetMuscleGroupId,
    String difficultyLevelId,
  ) async {
    var response = await _apiManager.execute<List<ExerciseEntity>>(() async {
      var response = await _homeRemoteDataSource.getDailyRecommendationExercise(
        limit,
        targetMuscleGroupId,
        difficultyLevelId,
      );
      return response.exercises!
          .map((exercise) => exercise.toEntity())
          .toList();
    });
    return response;
  }

  @override
  Future<Result<List<MealEntity>>> getFoodRecommendation() async {
    var response = await _apiManager.execute<List<MealEntity>>(() async {
      var response = await _homeRemoteDataSource.getFoodRecommendation();
      return response.meals.map((meal) => meal.toEntity()).toList();
    });
    return response;
  }

  @override
  Future<Result<List<CategoryEntity>>> getExerciseCategories() {
    var response = _apiManager.execute<List<CategoryEntity>>(() async {
      var response = await _homeLocalDataSource.getExerciseCategories();
      return response.map((category) => category.toEntity()).toList();
    });
    return response;
  }

  @override
  Future<Result<List<MuscleGroupEntity>?>> getAllMuscles() async {
    var response = await _apiManager.execute<List<MuscleGroupEntity>?>(
      () async {
        var response = await _homeRemoteDataSource.getAllMuscles();
        return response.musclesGroup
            ?.map((muscle) => muscle.toEntity())
            .toList();
      },
    );
    return response;
  }

  @override
  Future<Result<List<MuscleEntity>?>> getMusclesByGroup(String id) async {
    var response = await _apiManager.execute<List<MuscleEntity>?>(() async {
      var response = await _homeRemoteDataSource.getMusclesByGroup(id);
      return response.muscles.map((muscle) => muscle.toEntity()).toList();
    });
    return response;
  }
}
