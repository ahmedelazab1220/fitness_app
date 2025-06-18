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

class UserRegistrationAction extends RegisterAction {}
