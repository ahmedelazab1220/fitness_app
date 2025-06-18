part of 'login_cubit.dart';

class LoginState extends Equatable {
  final BaseState? baseState;

  const LoginState({this.baseState});

  LoginState copyWith({BaseState? baseState}) {
    return LoginState(baseState: baseState ?? this.baseState);
  }

  @override
  List<Object?> get props => [baseState];
}

sealed class LoginAction {}

class LoginRequestAction extends LoginAction {
  final String email;
  final String password;
  final bool isFormValid;

  LoginRequestAction({
    required this.email,
    required this.password,
    required this.isFormValid,
  });
}

final class NavigationAction extends LoginAction {
  final String routeName;
  final NavigationType type;

  NavigationAction({required this.routeName, this.type = NavigationType.push});
}
