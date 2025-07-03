import 'package:dio/dio.dart';
import 'package:fitness_app/data/excercise/model/response/exercises_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/utils/datasource_excution/api_constants.dart';
import '../model/response/difficulty_levels_response_dto.dart';

part 'exercise_retrofit_client.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ExerciseRetrofitClient {
  @factoryMethod
  factory ExerciseRetrofitClient(Dio dio) = _ExerciseRetrofitClient;

  @GET(ApiConstants.exercisesByMuscleDifficulty)
  Future<ExercisesResponseDto> getExercisesByMuscleAndDifficulty(
    @Query("primeMoverMuscleId") String? muscleId,
    @Query("difficultyLevelId") String? difficultyId,
  );

  @GET(ApiConstants.getAllDifficultyLevelsByPrimeMoverMuscle)
  Future<DifficultyLevelsResponseDto> getAllDifficultyLevelsByPrimeMoverMuscle(
    @Query("primeMoverMuscleId") String? muscleId,
  );
}
