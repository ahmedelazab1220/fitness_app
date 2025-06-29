import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/data/excercise/model/request/exercise_request_dto.dart';
import 'package:fitness_app/data/excercise/model/response/exercises_response_dto.dart';

abstract interface class ExerciseRepo {
  Future<Result<ExercisesResponseDto>> getExercisesByMuscleAndDifficulty(
    ExerciseRequestDto request,
  );
}
