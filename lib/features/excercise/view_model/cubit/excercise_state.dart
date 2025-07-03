import 'package:equatable/equatable.dart';

import '../../../../core/base/base_state.dart';

class ExcerciseState extends Equatable {
  final BaseState excerciseState;
  final BaseState difficultyState;
  final int selectedLevelIndex;
  const ExcerciseState({
    required this.excerciseState,
    required this.difficultyState,
    this.selectedLevelIndex = 0,
  });

  ExcerciseState copyWith({
    BaseState? excerciseState,
    BaseState? difficultyState,
    int? selectedLevelIndex,
  }) {
    return ExcerciseState(
      excerciseState: excerciseState ?? this.excerciseState,
      difficultyState: difficultyState ?? this.difficultyState,
      selectedLevelIndex: selectedLevelIndex ?? this.selectedLevelIndex,
    );
  }

  @override
  List<Object> get props => [
    excerciseState,
    difficultyState,
    selectedLevelIndex,
  ];
}

sealed class ExcerciseAction {}

final class GetExcerciseAction extends ExcerciseAction {
  final String muscleId;
  final String difficultyId;

  GetExcerciseAction({required this.muscleId, required this.difficultyId});
}

final class GetDifficultyLevelsAction extends ExcerciseAction {
  final String muscleId;

  GetDifficultyLevelsAction({required this.muscleId});
}

class SelectLevelAction extends ExcerciseAction {
  final String muscleId;
  final int index;

  SelectLevelAction(this.index, this.muscleId);
}
