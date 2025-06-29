import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/data/excercise/model/request/exercise_request_dto.dart';
import 'package:fitness_app/data/excercise/model/response/exercises_response_dto.dart';
import 'package:fitness_app/domain/excercise/repo/excercise_repo.dart';

class GetExercisesDetailsUseCase {
  final ExerciseRepo _exerciseRepo;

  GetExercisesDetailsUseCase(this._exerciseRepo);

  Future<Result<ExercisesResponseDto>> call(ExerciseRequestDto request) async {
    return await _exerciseRepo.getExercisesByMuscleAndDifficulty(request);
  }
}
