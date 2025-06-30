part of 'excercise_cubit.dart';

class ExcerciseState extends Equatable {
  final BaseState excerciseState;
  const ExcerciseState({required this.excerciseState});

  @override
  List<Object> get props => [excerciseState];
}

sealed class ExcerciseAction {}

final class GetExcerciseAction extends ExcerciseAction {
  final String muscleId;
  final String difficultyId;

  GetExcerciseAction({required this.muscleId, required this.difficultyId});
}
