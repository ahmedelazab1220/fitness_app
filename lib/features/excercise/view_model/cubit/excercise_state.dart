import 'package:equatable/equatable.dart';

import '../../../../core/base/base_state.dart';

class ExcerciseState extends Equatable {
  final BaseState difficultyState;
  final BaseState exerciseState;
  final int selectedLevelIndex;

  const ExcerciseState({
    required this.difficultyState,
    required this.exerciseState,
    this.selectedLevelIndex = 0,
  });

  ExcerciseState copyWith({
    BaseState? difficultyState,
    BaseState? exerciseState,
    int? selectedLevelIndex,
  }) {
    return ExcerciseState(
      difficultyState: difficultyState ?? this.difficultyState,
      exerciseState: exerciseState ?? this.exerciseState,
      selectedLevelIndex: selectedLevelIndex ?? this.selectedLevelIndex,
    );
  }

  @override
  List<Object?> get props => [
    difficultyState,
    exerciseState,
    selectedLevelIndex,
  ];
}

sealed class ExcerciseAction {}

final class GetDifficultyLevelsAction extends ExcerciseAction {
  final String muscleId;
  GetDifficultyLevelsAction({required this.muscleId});
}

final class GetExcerciseAction extends ExcerciseAction {
  final String muscleId;
  final String difficultyId;
  GetExcerciseAction({required this.muscleId, required this.difficultyId});
}

final class SelectLevelAction extends ExcerciseAction {
  final int index;
  final String muscleId;
  SelectLevelAction(this.index, this.muscleId);
}
