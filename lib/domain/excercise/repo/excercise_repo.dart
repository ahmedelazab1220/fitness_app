import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/data/excercise/model/request/exercise_request_dto.dart';
import 'package:fitness_app/data/excercise/model/response/exercises_response_dto.dart';

import '../../../data/excercise/model/request/difficulty_levels_request_dto.dart';
import '../../../data/excercise/model/response/difficulty_levels_response_dto.dart';

abstract interface class ExerciseRepo {
  Future<Result<ExercisesResponseDto>> getExercisesByMuscleAndDifficulty(
    ExerciseRequestDto request,
  );
  Future<Result<DifficultyLevelsResponseDto>> getDifficultyLevelsByMuscleId(
    DifficultyLevelsRequestDto request,
  );
}
