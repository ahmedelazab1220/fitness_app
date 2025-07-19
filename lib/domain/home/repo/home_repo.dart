import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/category_entity.dart';
import '../entity/meal_entity.dart';
import '../entity/exercise_entity.dart';
import '../entity/muscle_entity.dart';
import '../entity/muscle_group_entity.dart';

abstract class HomeRepo {
  Future<Result<List<ExerciseEntity>>> getDailyRecommendationExercise(
    int limit,
    String targetMuscleGroupId,
    String difficultyLevelId,
  );

  Future<Result<List<MealEntity>>> getFoodRecommendation();

  Future<Result<List<CategoryEntity>>> getExerciseCategories();

  Future<Result<List<MuscleGroupEntity>?>> getAllMuscles();

  Future<Result<List<MuscleEntity>?>> getMusclesByGroup(String id);
}
