import '../../models/daily_recommendation_exercise_dto.dart';
import '../../models/muscle_group_dto.dart';
import '../../models/recommendation_meals_dto.dart';
import '../../models/upcoming_workout_dto.dart';

abstract class HomeRemoteDataSource {
  Future<DailyRecommendationExerciseDto> getDailyRecommendationExercise(
    int limit,
    String targetMuscleGroupId,
    String difficultyLevelId,
  );

  Future<UpcomingWorkoutDto> getUpcomingWorkouts();

  Future<RecommendationMealsDto> getFoodRecommendation();

  Future<MuscleGroupDto> getAllMuscles();
}
