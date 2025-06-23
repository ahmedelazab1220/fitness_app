import 'package:fitness_app/data/workouts/models/muscles_response_dto.dart';
import 'package:fitness_app/data/workouts/models/workouts_response_dto.dart';

abstract class WorkoutsRemoteDataSource {
  Future<WorkoutsResponseDto> getAllMuscleGroups();

  Future<MusclesResponseDto> getAllMusclesByMuscleGroup(String muscleGroupId);
}
