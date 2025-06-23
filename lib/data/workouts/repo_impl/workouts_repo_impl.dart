import 'package:fitness_app/core/utils/datasource_excution/api_manager.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/domain/workouts/entity/msucles_group_entity.dart';
import 'package:fitness_app/domain/workouts/entity/muscles_entity.dart';
import 'package:fitness_app/domain/workouts/repo/workouts_repo.dart';
import 'package:injectable/injectable.dart';

import '../data_source/contract/workouts_remote_data_source.dart';

@Injectable(as: WorkoutsRepo)
class WorkoutsRepoImpl implements WorkoutsRepo {
  final WorkoutsRemoteDataSource _workoutsRemoteDataSource;
  final ApiManager _apiManager;

  WorkoutsRepoImpl(this._workoutsRemoteDataSource, this._apiManager);

  @override
  Future<Result<List<MusclesGroupEntity>>> getAllMuscleGroups() async {
    final result = await _apiManager.execute<List<MusclesGroupEntity>>(
      () async {
        final response = await _workoutsRemoteDataSource.getAllMuscleGroups();
        return response.musclesGroup!
            .map((muscleGroup) => muscleGroup.toEntity())
            .toList();
      },
    );
    return result;
  }

  @override
  Future<Result<List<MusclesEntity>>> getAllMusclesByMuscleGroup(
    String muscleGroupId,
  ) async {
    final result = await _apiManager.execute<List<MusclesEntity>>(() async {
      final response = await _workoutsRemoteDataSource
          .getAllMusclesByMuscleGroup(muscleGroupId);
      return response.muscles!.map((muscle) => muscle.toEntity()).toList();
    });
    return result;
  }
}
