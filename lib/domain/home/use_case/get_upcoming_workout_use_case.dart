import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/exercise_entity.dart';
import '../repo/home_repo.dart';

@injectable
class GetUpcomingWorkoutUseCase {
  final HomeRepo _homeRepo;

  GetUpcomingWorkoutUseCase(this._homeRepo);

  Future<Result<List<ExerciseEntity>>> call() async =>
      await _homeRepo.getUpcomingWorkouts();
}
