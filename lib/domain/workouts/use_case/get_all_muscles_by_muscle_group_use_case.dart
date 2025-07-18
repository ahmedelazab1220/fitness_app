import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/domain/workouts/repo/workouts_repo.dart';
import 'package:injectable/injectable.dart';

import '../entity/muscles_entity.dart';

@injectable
class GetAllMusclesByMuscleGroupUseCase {
  final WorkoutsRepo _workoutsRepo;

  GetAllMusclesByMuscleGroupUseCase(this._workoutsRepo);

  Future<Result<List<MusclesEntity>>> call(String muscleGroupId) async {
    return await _workoutsRepo.getAllMusclesByMuscleGroup(muscleGroupId);
  }
}
