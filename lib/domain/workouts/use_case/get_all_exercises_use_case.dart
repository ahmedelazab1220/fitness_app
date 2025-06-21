import 'package:fitness_app/domain/workouts/repo/workouts_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/exercise_entity.dart';

@injectable
class GetAllExercisesUseCase {
  final WorkoutsRepo _workoutsRepo;

  GetAllExercisesUseCase(this._workoutsRepo);

  Future<Result<List<ExerciseEntity>>> call() async {
    return await _workoutsRepo.getAllExercises();
  }
}
