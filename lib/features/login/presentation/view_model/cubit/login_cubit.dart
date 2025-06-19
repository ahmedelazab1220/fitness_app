import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/base/base_state.dart';
import '../../../../../core/utils/datasource_excution/api_result.dart';
import '../../../../../core/utils/validator/validator.dart';
import '../../../../../data/auth/models/request/login_request_dto.dart';
import '../../../../../data/auth/models/response/login_response_dto.dart';
import '../../../../../domain/auth/use_case/login_use_case.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final Validator validator;

  LoginCubit(this._loginUseCase, this.validator)
    : super(LoginState(loginState: BaseInitialState()));

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void doIntent(LoginAction action) {
    switch (action) {
      case LoginRequestAction():
        _login();
    }
  }

  Future<void> _login() async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(baseState: BaseLoadingState()));
      final result = await _loginUseCase.call(
        LoginRequestDto(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
      switch (result) {
        case SuccessResult<LoginResponseDto>():
          emit(state.copyWith(baseState: BaseSuccessState()));
        case FailureResult<LoginResponseDto>():
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

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.close();
  }
}
