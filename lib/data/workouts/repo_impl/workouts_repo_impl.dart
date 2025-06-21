import 'package:fitness_app/core/utils/datasource_excution/api_manager.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/domain/workouts/entity/exercise_entity.dart';
import 'package:fitness_app/domain/workouts/entity/msucles_group_entity.dart';
import 'package:fitness_app/domain/workouts/repo/workouts_repo.dart';
import 'package:injectable/injectable.dart';

import '../data_source/contract/workouts_remote_data_source.dart';

@Injectable(as: WorkoutsRepo)
class WorkoutsRepoImpl implements WorkoutsRepo {
  final WorkoutsRemoteDataSource _workoutsRemoteDataSource;
  final ApiManager _apiManager;

  WorkoutsRepoImpl(this._workoutsRemoteDataSource, this._apiManager);

  @override
  Future<Result<List<MusclesGroupEntity>>> getAllMuscles() async {
    final result = await _apiManager.execute<List<MusclesGroupEntity>>(
      () async {
        final response = await _workoutsRemoteDataSource.getAllMuscles();
        return response.musclesGroup!
            .map((muscleGroup) => muscleGroup.toEntity())
            .toList();
      },
    );
    return result;
  }

  @override
  Future<Result<List<ExerciseEntity>>> getAllExercises() async {
    final result = await _apiManager.execute<List<ExerciseEntity>>(() async {
      final response = await _workoutsRemoteDataSource.getAllExercises();
      return response.exercises!
          .map((exercise) => exercise.toEntity())
          .toList();
    });
    return result;
  }
}
