import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/domain/workouts/entity/msucles_group_entity.dart';
import 'package:fitness_app/domain/workouts/use_case/get_all_exercises_use_case.dart';
import 'package:fitness_app/domain/workouts/use_case/get_all_muscles_use_case.dart';
import 'package:fitness_app/features/workouts/presentation/view_model/workouts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base/base_state.dart';
import '../../../../domain/workouts/entity/exercise_entity.dart';

@injectable
class WorkoutsCubit extends Cubit<WorkoutsState> {
  final GetAllMusclesUseCase _allMusclesUseCase;
  final GetAllExercisesUseCase _getAllExercisesUseCase;

  WorkoutsCubit(this._allMusclesUseCase, this._getAllExercisesUseCase)
    : super(
        WorkoutsState(
          workoutsState: BaseInitialState(),
          exerciseState: BaseInitialState(),
        ),
      );

  List<ExerciseEntity> _allExercises = [];

  void doIntent(WorkoutsAction action) {
    switch (action) {
      case GetAllWorkoutsAction():
        _getAllMuscles();
      case GetAllExercisesAction():
        _getAllExercises();
      case SelectWorkoutTabAction():
        _selectWorkoutTab(action.index);
    }
  }

  Future<void> _getAllMuscles() async {
    emit(state.copyWith(workoutsState: BaseLoadingState()));
    final result = await _allMusclesUseCase();
    switch (result) {
      case SuccessResult<List<MusclesGroupEntity>>():
        emit(
          state.copyWith(
            workoutsState: BaseSuccessState<List<MusclesGroupEntity>>(
              data: result.data,
            ),
          ),
        );
      case FailureResult<List<MusclesGroupEntity>>():
        emit(
          state.copyWith(
            workoutsState: BaseErrorState(
              errorMessage: result.exception.toString(),
            ),
          ),
        );
    }
  }

  Future<void> _getAllExercises() async {
    emit(state.copyWith(exerciseState: BaseLoadingState()));
    final result = await _getAllExercisesUseCase();
    switch (result) {
      case SuccessResult<List<ExerciseEntity>>():
        _allExercises = result.data;
        _filterExercisesByMuscleGroup(state.selectedIndex);
        emit(
          state.copyWith(
            exerciseState: BaseSuccessState<List<ExerciseEntity>>(
              data: _allExercises,
            ),
          ),
        );
      case FailureResult<List<ExerciseEntity>>():
        emit(
          state.copyWith(
            exerciseState: BaseErrorState(
              errorMessage: result.exception.toString(),
            ),
          ),
        );
    }
  }

  void _selectWorkoutTab(int index) {
    if (index == state.selectedIndex) return;
    _filterExercisesByMuscleGroup(index);
    emit(state.copyWith(selectedIndex: index));
  }

  void _filterExercisesByMuscleGroup(int index) {
    final workouts = state.workoutsState;
    if (workouts is BaseSuccessState<List<MusclesGroupEntity>>) {
      final selectedMuscleName = workouts.data![index].name;
      final filtered = _allExercises
          .where(
            (exercise) =>
                exercise.targetMuscleGroup?.toLowerCase().trim() ==
                selectedMuscleName?.toLowerCase().trim(),
          )
          .toList();

      emit(state.copyWith(filteredExercises: filtered));
    }
  }

  String? getYoutubeThumbnail(String? youtubeUrl) {
    if (youtubeUrl == null) return null;
    final uri = Uri.tryParse(youtubeUrl);
    final videoId =
        uri?.queryParameters['v'] ??
        uri?.pathSegments.lastWhere(
          (segment) => segment.isNotEmpty,
          orElse: () => '',
        );
    if (videoId == null || videoId.isEmpty) return null;
    return 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
  }
}
