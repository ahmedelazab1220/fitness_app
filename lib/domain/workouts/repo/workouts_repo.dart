import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/domain/workouts/entity/msucles_group_entity.dart';

import '../entity/exercise_entity.dart';

abstract class WorkoutsRepo {
  Future<Result<List<MusclesGroupEntity>>> getAllMuscles();

  Future<Result<List<ExerciseEntity>>> getAllExercises();
}
