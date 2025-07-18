import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/utils/datasource_excution/api_result.dart';
import '../../../../domain/workouts/entity/msucles_group_entity.dart';
import '../../../../domain/workouts/entity/muscles_entity.dart';
import '../../../../domain/workouts/use_case/get_all_muscle_groups_use_case.dart';
import '../../../../domain/workouts/use_case/get_all_muscles_by_muscle_group_use_case.dart';
import 'workouts_state.dart';

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
        _getAllMuscleGroups(action.index);
      case GetAllMusclesByMuscleGroupAction():
        _getAllMusclesByMuscleGroup(action.muscleGroupId);
      case SelectWorkoutTabAction():
        _selectWorkoutTab(action.index);
    }
  }

  Future<void> _getAllMuscleGroups(int index) async {
    emit(
      state.copyWith(
        muscleGroupsState: BaseLoadingState(),
        selectedIndex: index,
      ),
    );
    final result = await _getAllMuscleGroupsUseCase();
    switch (result) {
      case SuccessResult<List<MusclesGroupEntity>>():
        {
          emit(
            state.copyWith(
              muscleGroupsState: BaseSuccessState<List<MusclesGroupEntity>>(
                data: result.data,
              ),
            ),
          );
          _selectWorkoutTab(index);
        }
      case FailureResult<List<MusclesGroupEntity>>():
        {
          emit(
            state.copyWith(
              muscleGroupsState: BaseErrorState(
                errorMessage: result.exception.toString(),
              ),
            ),
          );
        }
    }
  }

  Future<void> _getAllMusclesByMuscleGroup(String muscleGroupId) async {
    emit(state.copyWith(musclesState: BaseLoadingState()));
    final result = await _getAllMusclesByMuscleGroupUseCase(muscleGroupId);
    switch (result) {
      case SuccessResult<List<MusclesEntity>>():
        {
          emit(
            state.copyWith(
              musclesState: BaseSuccessState<List<MusclesEntity>>(
                data: result.data,
              ),
            ),
          );
        }
      case FailureResult<List<MusclesEntity>>():
        {
          emit(
            state.copyWith(
              musclesState: BaseErrorState(
                errorMessage: result.exception.toString(),
              ),
            ),
          );
        }
    }
  }

  void _selectWorkoutTab(int index) {
    if (index < 0 ||
        index == state.selectedIndex ||
        index >=
            (state.muscleGroupsState
                    as BaseSuccessState<List<MusclesGroupEntity>>)
                .data!
                .length) {
      return;
    }
    final selectedMuscleGroup =
        (state.muscleGroupsState as BaseSuccessState<List<MusclesGroupEntity>>)
            .data![index];
    _getAllMusclesByMuscleGroup(selectedMuscleGroup.id!);
    emit(state.copyWith(selectedIndex: index));
  }
}
