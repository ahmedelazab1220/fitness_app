import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/muscle_entity.dart';
import '../repo/home_repo.dart';

@injectable
class GetMusclesByGroupUseCase {
  final HomeRepo _homeRepo;

  GetMusclesByGroupUseCase(this._homeRepo);

  Future<Result<List<MuscleEntity>?>> call(String id) async =>
      await _homeRepo.getMusclesByGroup(id);
}
