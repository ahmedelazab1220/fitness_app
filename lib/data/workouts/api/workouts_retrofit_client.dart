import 'package:dio/dio.dart';
import 'package:fitness_app/data/workouts/models/muscles_response_dto.dart';
import 'package:fitness_app/data/workouts/models/workouts_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/utils/datasource_excution/api_constants.dart';

part 'workouts_retrofit_client.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class WorkoutsRetrofitClient {
  @factoryMethod
  factory WorkoutsRetrofitClient(Dio dio) = _WorkoutsRetrofitClient;

  @GET(ApiConstants.allMuscles)
  Future<WorkoutsResponseDto> getAllMuscleGroups();

  @GET("${ApiConstants.allMusclesGroup}/{muscleGroupId}")
  Future<MusclesResponseDto> getAllMusclesByMuscleGroup(
    @Path("muscleGroupId") String muscleGroupId,
  );
}
