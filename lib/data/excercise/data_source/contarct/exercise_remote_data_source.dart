import 'package:fitness_app/data/excercise/model/response/exercises_response_dto.dart';
import 'package:injectable/injectable.dart';

@injectable
abstract interface class ExerciseRemoteDataSource {
  Future<ExercisesResponseDto> getExercisesByMuscleAndDifficulty(
    String muscleId,
    String difficultyId,
  );
}
