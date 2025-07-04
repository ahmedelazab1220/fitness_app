import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../../../data/excercise/model/request/difficulty_levels_request_dto.dart';
import '../../../data/excercise/model/response/difficulty_levels_response_dto.dart';
import '../repo/excercise_repo.dart';

@injectable
class GetDifficultyLevelsByMuscleIdUseCase {
  final ExerciseRepo _exerciseRepo;
  GetDifficultyLevelsByMuscleIdUseCase(this._exerciseRepo);

  Future<Result<DifficultyLevelsResponseDto>> call(
    DifficultyLevelsRequestDto request,
  ) async {
    return await _exerciseRepo.getDifficultyLevelsByMuscleId(request);
  }
}
