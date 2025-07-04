import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/domain/workouts/entity/msucles_group_entity.dart';
import 'package:fitness_app/domain/workouts/entity/muscles_entity.dart';
import 'package:fitness_app/domain/workouts/use_case/get_all_muscle_groups_use_case.dart';
import 'package:fitness_app/domain/workouts/use_case/get_all_muscles_by_muscle_group_use_case.dart';
import 'package:fitness_app/features/workouts/presentation/view_model/workouts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base/base_state.dart';

@injectable
class WorkoutsCubit extends Cubit<WorkoutsState> {
  final GetAllMuscleGroupsUseCase _getAllMuscleGroupsUseCase;
  final GetAllMusclesByMuscleGroupUseCase _getAllMusclesByMuscleGroupUseCase;

  WorkoutsCubit(
    this._getAllMuscleGroupsUseCase,
    this._getAllMusclesByMuscleGroupUseCase,
  ) : super(
        WorkoutsState(
          muscleGroupsState: BaseInitialState(),
          musclesState: BaseInitialState(),
        ),
      );

  void doIntent(WorkoutsAction action) {
    switch (action) {
      case GetAllMuscleGroupsAction():
        _getAllMuscleGroups();
      case GetAllMusclesByMuscleGroupAction():
        _getAllMusclesByMuscleGroup(action.muscleGroupId);
      case SelectWorkoutTabAction():
        _selectWorkoutTab(action.index);
    }
  }

  Future<void> _getAllMuscleGroups() async {
    emit(state.copyWith(muscleGroupsState: BaseLoadingState()));
    final result = await _getAllMuscleGroupsUseCase();
    switch (result) {
      case SuccessResult<List<MusclesGroupEntity>>():
        emit(
          state.copyWith(
            muscleGroupsState: BaseSuccessState<List<MusclesGroupEntity>>(
              data: result.data,
            ),
          ),
        );
      case FailureResult<List<MusclesGroupEntity>>():
        emit(
          state.copyWith(
            muscleGroupsState: BaseErrorState(
              errorMessage: result.exception.toString(),
            ),
          ),
        );
    }
  }

  Future<void> _getAllMusclesByMuscleGroup(String muscleGroupId) async {
    emit(state.copyWith(musclesState: BaseLoadingState()));
    final result = await _getAllMusclesByMuscleGroupUseCase(muscleGroupId);
    switch (result) {
      case SuccessResult<List<MusclesEntity>>():
        emit(
          state.copyWith(
            musclesState: BaseSuccessState<List<MusclesEntity>>(
              data: result.data,
            ),
          ),
        );
      case FailureResult<List<MusclesEntity>>():
        emit(
          state.copyWith(
            musclesState: BaseErrorState(
              errorMessage: result.exception.toString(),
            ),
          ),
        );
    }
  }

  void _selectWorkoutTab(int index) {
    if (index == state.selectedIndex) return;
    final selectedMuscleGroup =
        (state.muscleGroupsState as BaseSuccessState<List<MusclesGroupEntity>>)
            .data![index];
    _getAllMusclesByMuscleGroup(selectedMuscleGroup.id!);
    emit(state.copyWith(selectedIndex: index));
  }
}
