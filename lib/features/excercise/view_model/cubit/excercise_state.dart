part of 'excercise_cubit.dart';

sealed class ExcerciseState extends Equatable {
  const ExcerciseState();

  @override
  List<Object> get props => [];
}

final class ExcerciseInitial extends ExcerciseState {}
