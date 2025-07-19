import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/muscle_group_entity.dart';
import '../repo/home_repo.dart';

@injectable
class GetAllMusclesUseCase {
  final HomeRepo _homeRepo;

  GetAllMusclesUseCase(this._homeRepo);

  Future<Result<List<MuscleGroupEntity>?>> call() async =>
      await _homeRepo.getAllMuscles();
}
