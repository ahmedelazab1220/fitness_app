import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/base/base_state.dart';
import '../../../../../core/utils/datasource_excution/api_result.dart';
import '../../../../../core/utils/validator/validator.dart';
import '../../../../../domain/auth/entity/login_request_entity.dart';
import '../../../../../domain/auth/use_case/login_use_case.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final Validator validator;

  LoginCubit(this._loginUseCase, this.validator)
    : super(LoginState(baseState: BaseInitialState()));

  void doIntent(LoginAction action) {
    if (action is LoginRequestAction) {
      _login(
        email: action.email,
        password: action.password,
        isFormValid: action.isFormValid,
      );
    } else if (action is NavigationAction) {
      _navigationToScreen(routeName: action.routeName, type: action.type);
    }
  }

  Future<void> _login({
    required String email,
    required String password,
    required bool isFormValid,
  }) async {
    if (isFormValid) {
      emit(state.copyWith(baseState: BaseLoadingState()));
      final result = await _loginUseCase.call(
        LoginRequest(email: email, password: password),
      );

      switch (result) {
        case SuccessResult<void>():
          emit(state.copyWith(baseState: BaseSuccessState()));
        case FailureResult<void>():
          emit(
            state.copyWith(
              baseState: BaseErrorState(
                errorMessage: result.exception.toString(),
              ),
            ),
          );
      }
    }
  }

  void _navigationToScreen({
    required String routeName,
    required NavigationType type,
  }) {
    emit(
      state.copyWith(
        baseState: BaseNavigationState(routeName: routeName, type: type),
      ),
    );
  }
}
