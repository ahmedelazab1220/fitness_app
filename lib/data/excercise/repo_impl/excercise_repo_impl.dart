import 'package:fitness_app/core/utils/datasource_excution/api_manager.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/data/excercise/data_source/contarct/exercise_remote_data_source.dart';
import 'package:fitness_app/data/excercise/model/request/difficulty_levels_request_dto.dart';
import 'package:fitness_app/data/excercise/model/request/exercise_request_dto.dart';
import 'package:fitness_app/data/excercise/model/response/difficulty_levels_response_dto.dart';
import 'package:fitness_app/data/excercise/model/response/exercises_response_dto.dart';
import 'package:fitness_app/domain/excercise/repo/excercise_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExerciseRepo)
class ExerciseRepoImpl implements ExerciseRepo {
  final ExerciseRemoteDataSource _exerciseRemoteDataSource;
  final ApiManager _apiManager;

  ExerciseRepoImpl(this._exerciseRemoteDataSource, this._apiManager);

  @override
  Future<Result<ExercisesResponseDto>> getExercisesByMuscleAndDifficulty(
    ExerciseRequestDto request,
  ) async {
    return await _apiManager.execute<ExercisesResponseDto>(
      () async => await _exerciseRemoteDataSource
          .getExercisesByMuscleAndDifficulty(request),
    );
  }

  @override
  Future<Result<DifficultyLevelsResponseDto>> getDifficultyLevelsByMuscleId(
    DifficultyLevelsRequestDto request,
  ) async {
    return await _apiManager.execute<DifficultyLevelsResponseDto>(
      () async => await _exerciseRemoteDataSource.getDifficultyLevelsByMuscleId(
        request,
      ),
    );
  }
}
