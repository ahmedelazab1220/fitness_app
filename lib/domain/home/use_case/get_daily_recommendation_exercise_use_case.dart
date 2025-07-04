import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/exercise_entity.dart';
import '../repo/home_repo.dart';

@injectable
class GetDailyRecommendationExerciseUseCase {
  final HomeRepo _homeRepo;

  GetDailyRecommendationExerciseUseCase(this._homeRepo);

  Future<Result<List<ExerciseEntity>>> call(
    int limit,
    String targetMuscleGroupId,
    String difficultyLevelId,
  ) async => _homeRepo.getDailyRecommendationExercise(
    limit,
    targetMuscleGroupId,
    difficultyLevelId,
  );
}
