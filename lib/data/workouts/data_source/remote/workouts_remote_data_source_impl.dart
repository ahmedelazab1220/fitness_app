import 'package:fitness_app/data/workouts/api/workouts_retrofit_client.dart';
import 'package:fitness_app/data/workouts/data_source/contract/workouts_remote_data_source.dart';
import 'package:fitness_app/data/workouts/models/exercises_response_dto.dart';
import 'package:fitness_app/data/workouts/models/workouts_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: WorkoutsRemoteDataSource)
class WorkoutsRemoteDataSourceImpl implements WorkoutsRemoteDataSource {
  final WorkoutsRetrofitClient _workoutsRetrofitClient;

  WorkoutsRemoteDataSourceImpl(this._workoutsRetrofitClient);

  @override
  Future<WorkoutsResponseDto> getAllMuscles() async {
    return await _workoutsRetrofitClient.getAllMuscles();
  }

  @override
  Future<ExercisesResponseDto> getAllExercises() async {
    return await _workoutsRetrofitClient.getAllExercises();
  }
}
