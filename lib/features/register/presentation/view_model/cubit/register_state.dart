part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final BaseState? registerState;
  const RegisterState({this.registerState});

  RegisterState copyWith({BaseState? registerState}) {
    return RegisterState(registerState: registerState ?? this.registerState);
  }

  @override
  List<Object?> get props => [registerState];
}

sealed class RegisterAction {}

class UserRegistrationAction extends RegisterAction {}
