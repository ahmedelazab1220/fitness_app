import 'package:dio/dio.dart';
import 'package:fitness_app/data/home/models/muscles_by_group_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/utils/datasource_excution/api_constants.dart';
import '../models/daily_recommendation_exercise_dto.dart';
import '../models/muscles_group_dto.dart';
import '../models/recommendation_meals_dto.dart';

part 'home_retrofit_client.g.dart';

@singleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class HomeRetrofitClient {
  @factoryMethod
  factory HomeRetrofitClient(Dio dio) = _HomeRetrofitClient;

  @GET(ApiConstants.exercisesByRandom)
  Future<DailyRecommendationExerciseDto> getDailyRecommendationExercise(
    @Query('limit') int limit,
    @Query('targetMuscleGroupId') String targetMuscleGroupId,
    @Query('difficultyLevelId') String difficultyLevelId,
  );

  @GET(ApiConstants.mealsCategories)
  Future<RecommendationMealsDto> getFoodRecommendation();

  @GET(ApiConstants.allMuscles)
  Future<MusclesGroupDto> getAllMuscles();

  @GET("${ApiConstants.allMusclesGroup}/{id}")
  Future<MusclesByGroupResponse> getMusclesByGroup(@Path("id") String id);
}
