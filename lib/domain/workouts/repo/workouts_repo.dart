import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/domain/workouts/entity/msucles_group_entity.dart';
import 'package:fitness_app/domain/workouts/entity/muscles_entity.dart';

abstract class WorkoutsRepo {
  Future<Result<List<MusclesGroupEntity>>> getAllMuscleGroups();

  Future<Result<List<MusclesEntity>>> getAllMusclesByMuscleGroup(
    String muscleGroupId,
  );
}
