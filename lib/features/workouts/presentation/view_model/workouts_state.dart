import 'package:equatable/equatable.dart';

import '../../../../core/base/base_state.dart';

class WorkoutsState extends Equatable {
  final BaseState muscleGroupsState;
  final BaseState musclesState;
  final int selectedIndex;

  const WorkoutsState({
    required this.muscleGroupsState,
    required this.musclesState,
    this.selectedIndex = 0,
  });

  WorkoutsState copyWith({
    BaseState? muscleGroupsState,
    BaseState? musclesState,
    int? selectedIndex,
  }) {
    return WorkoutsState(
      muscleGroupsState: muscleGroupsState ?? this.muscleGroupsState,
      musclesState: musclesState ?? this.musclesState,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [muscleGroupsState, musclesState, selectedIndex];
}

sealed class WorkoutsAction {}

final class GetAllMuscleGroupsAction extends WorkoutsAction {
  final int index;

  GetAllMuscleGroupsAction(this.index);
}

final class GetAllMusclesByMuscleGroupAction extends WorkoutsAction {
  final String muscleGroupId;

  GetAllMusclesByMuscleGroupAction(this.muscleGroupId);
}

final class SelectWorkoutTabAction extends WorkoutsAction {
  final int index;

  SelectWorkoutTabAction(this.index);
}
