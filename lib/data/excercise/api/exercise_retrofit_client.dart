import 'package:dio/dio.dart';
import 'package:fitness_app/data/excercise/model/response/exercises_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/utils/datasource_excution/api_constants.dart';

part 'exercise_retrofit_client.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ExerciseRetrofitClient {
  @factoryMethod
  factory ExerciseRetrofitClient(Dio dio) = _ExerciseRetrofitClient;

  @GET(ApiConstants.exercisesByMuscleDifficulty)
  Future<ExercisesResponseDto> getExercisesByMuscleAndDifficulty(
    @Path("primeMoverMuscleId") String muscleId,
    @Path("difficultyLevelId") String difficultyId,
  );

}