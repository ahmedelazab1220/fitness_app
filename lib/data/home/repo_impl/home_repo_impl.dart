import 'package:fitness_app/domain/home/entity/muscle_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_manager.dart';
import '../../../core/utils/datasource_excution/api_result.dart';
import '../../../domain/home/entity/category_entity.dart';
import '../../../domain/home/entity/meal_entity.dart';
import '../../../domain/home/entity/exercise_entity.dart';
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
  Future<Result<List<ExerciseEntity>>> getUpcomingWorkouts() async {
    var resposne = await _apiManager.execute<List<ExerciseEntity>>(() async {
      var response = await _homeRemoteDataSource.getUpcomingWorkouts();
      return response.exercises!
          .map((exercise) => exercise.toEntity())
          .toList();
    });
    return resposne;
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
  Future<Result<List<MuscleEntity>>> getAllMuscles() {
    var response = _apiManager.execute<List<MuscleEntity>>(() async {
      var response = await _homeRemoteDataSource.getAllMuscles();
      return response.muscles!.map((muscle) => muscle.toEntity()).toList();
    });
    return response;
  }
}
