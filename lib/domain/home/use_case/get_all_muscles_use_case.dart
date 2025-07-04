import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/muscle_entity.dart';
import '../repo/home_repo.dart';

@injectable
class GetAllMusclesUseCase {
  final HomeRepo _homeRepo;

  GetAllMusclesUseCase(this._homeRepo);

  Future<Result<List<MuscleEntity>>> call() async =>
      await _homeRepo.getAllMuscles();
}
