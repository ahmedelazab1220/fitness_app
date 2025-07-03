import 'package:fitness_app/data/home/models/muscle_group_dto.dart';
import 'package:injectable/injectable.dart';

import '../../api/home_retrofit_client.dart';
import '../../models/daily_recommendation_exercise_dto.dart';
import '../../models/recommendation_meals_dto.dart';
import '../../models/upcoming_workout_dto.dart';
import '../contract/home_remote_data_source.dart';

@Singleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final HomeRetrofitClient _homeRetrofitClient;

  HomeRemoteDataSourceImpl(this._homeRetrofitClient);

  @override
  Future<DailyRecommendationExerciseDto> getDailyRecommendationExercise(
    int limit,
    String targetMuscleGroupId,
    String difficultyLevelId,
  ) async {
    var response = await _homeRetrofitClient.getDailyRecommendationExercise(
      limit,
      targetMuscleGroupId,
      difficultyLevelId,
    );
    return response;
  }

  @override
  Future<RecommendationMealsDto> getFoodRecommendation() async {
    var response = await _homeRetrofitClient.getFoodRecommendation();
    return response;
  }

  @override
  Future<UpcomingWorkoutDto> getUpcomingWorkouts() async {
    var response = await _homeRetrofitClient.getUpcomingWorkouts();
    return response;
  }

  @override
  Future<MuscleGroupDto> getAllMuscles() {
    var response = _homeRetrofitClient.getAllMuscles();
    return response;
  }
}
