import 'package:fitness_app/domain/workouts/repo/workouts_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/msucles_group_entity.dart';

@injectable
class GetAllMusclesUseCase {
  final WorkoutsRepo _workoutsRepo;

  GetAllMusclesUseCase(this._workoutsRepo);

  Future<Result<List<MusclesGroupEntity>>> call() async {
    return await _workoutsRepo.getAllMuscles();
  }
}
