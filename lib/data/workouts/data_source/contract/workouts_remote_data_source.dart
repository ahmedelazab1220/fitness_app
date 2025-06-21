import 'package:fitness_app/data/workouts/models/workouts_response_dto.dart';

import '../../models/exercises_response_dto.dart';

abstract class WorkoutsRemoteDataSource {
  Future<WorkoutsResponseDto> getAllMuscles();

  Future<ExercisesResponseDto> getAllExercises();
}
