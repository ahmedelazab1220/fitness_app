import 'package:fitness_app/data/excercise/model/request/difficulty_levels_request_dto.dart';
import 'package:fitness_app/data/excercise/model/request/exercise_request_dto.dart';
import 'package:fitness_app/data/excercise/model/response/exercises_response_dto.dart';

import '../../model/response/difficulty_levels_response_dto.dart';

abstract interface class ExerciseRemoteDataSource {
  Future<ExercisesResponseDto> getExercisesByMuscleAndDifficulty(
    ExerciseRequestDto request,
  );

  Future<DifficultyLevelsResponseDto> getDifficultyLevelsByMuscleId(
    DifficultyLevelsRequestDto request,
  );
}
