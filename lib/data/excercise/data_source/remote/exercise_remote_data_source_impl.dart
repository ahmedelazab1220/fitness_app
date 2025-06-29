import 'package:fitness_app/data/excercise/model/request/exercise_request_dto.dart';
import 'package:fitness_app/data/excercise/model/response/exercises_response_dto.dart';
import 'package:injectable/injectable.dart';

import '../../api/exercise_retrofit_client.dart';
import '../contarct/exercise_remote_data_source.dart';

@Injectable(as: ExerciseRemoteDataSource)
class ExerciseRemoteDataSourceImpl implements ExerciseRemoteDataSource {
  final ExerciseRetrofitClient _exerciseRetrofitClient;
  ExerciseRemoteDataSourceImpl(this._exerciseRetrofitClient);
  @override
  Future<ExercisesResponseDto> getExercisesByMuscleAndDifficulty(
    ExerciseRequestDto request,
  ) async {
    return await _exerciseRetrofitClient.getExercisesByMuscleAndDifficulty(
      request.muscleId,
      request.difficultyId,
    );
  }
}
