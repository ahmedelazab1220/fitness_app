import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/base/base_state.dart';
import 'package:fitness_app/domain/workouts/entity/exercise_entity.dart';

class WorkoutsState extends Equatable {
  final BaseState workoutsState;
  final BaseState exerciseState;
  final List<ExerciseEntity> filteredExercises;
  final int selectedIndex;

  const WorkoutsState({
    required this.workoutsState,
    required this.exerciseState,
    this.filteredExercises = const [],
    this.selectedIndex = 0,
  });

  WorkoutsState copyWith({
    BaseState? workoutsState,
    BaseState? exerciseState,
    List<ExerciseEntity>? filteredExercises,
    int? selectedIndex,
  }) {
    return WorkoutsState(
      workoutsState: workoutsState ?? this.workoutsState,
      exerciseState: exerciseState ?? this.exerciseState,
      filteredExercises: filteredExercises ?? this.filteredExercises,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [
    workoutsState,
    exerciseState,
    filteredExercises,
    selectedIndex,
  ];
}

sealed class WorkoutsAction {}

class GetAllWorkoutsAction extends WorkoutsAction {}

class GetAllExercisesAction extends WorkoutsAction {}

class SelectWorkoutTabAction extends WorkoutsAction {
  final int index;

  SelectWorkoutTabAction(this.index);
}
