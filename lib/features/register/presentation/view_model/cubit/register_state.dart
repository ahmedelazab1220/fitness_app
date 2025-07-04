part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final BaseState? registerState;
  final int stepIndex;
  final String? gender;
  final int? age;
  final int? weight;
  final int? height;
  final String? goal;
  final String? activity;

  const RegisterState({
    this.registerState,
    this.stepIndex = 0,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.goal,
    this.activity,
  });

  RegisterState copyWith({
    BaseState? registerState,
    int? stepIndex,
    String? gender,
    int? age,
    int? weight,
    int? height,
    String? goal,
    String? activity,
  }) {
    return RegisterState(
      registerState: registerState ?? this.registerState,
      stepIndex: stepIndex ?? this.stepIndex,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      goal: goal ?? this.goal,
      activity: activity ?? this.activity,
    );
  }

  @override
  List<Object?> get props => [
    registerState,
    stepIndex,
    gender,
    age,
    weight,
    height,
    goal,
    activity,
  ];
}

sealed class RegisterAction {}

final class UserRegistrationAction extends RegisterAction {}

final class SetGenderAction extends RegisterAction {
  final String gender;

  SetGenderAction(this.gender);
}

final class SetAgeAction extends RegisterAction {
  final int age;

  SetAgeAction(this.age);
}

final class SetWeightAction extends RegisterAction {
  final int weight;

  SetWeightAction(this.weight);
}

final class SetHeightAction extends RegisterAction {
  final int height;

  SetHeightAction(this.height);
}

final class SetGoalAction extends RegisterAction {
  final String goal;

  SetGoalAction(this.goal);
}

final class SetActivityAction extends RegisterAction {
  final String activity;

  SetActivityAction(this.activity);
}

final class NextStepAction extends RegisterAction {}

final class PreviousStepAction extends RegisterAction {}
