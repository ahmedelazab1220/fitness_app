part of 'login_cubit.dart';

class LoginState extends Equatable {
  final BaseState? loginState;

  const LoginState({this.loginState});

  LoginState copyWith({BaseState? baseState}) {
    return LoginState(loginState: baseState ?? loginState);
  }

  @override
  List<Object?> get props => [loginState];
}

sealed class LoginAction {}

final class LoginRequestAction extends LoginAction {}
