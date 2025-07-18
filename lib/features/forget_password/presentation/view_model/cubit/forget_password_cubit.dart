import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/base/base_state.dart';
import '../../../../../core/utils/datasource_excution/api_result.dart';
import '../../../../../core/utils/validator/validator.dart';
import '../../../../../domain/auth/entity/forget_password/forget_password_request_entity.dart';
import '../../../../../domain/auth/entity/forget_password/forget_password_response_entity.dart';
import '../../../../../domain/auth/use_case/forget_password_use_case.dart';

part 'forget_password_state.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final Validator validator;

  ForgetPasswordCubit(this._forgetPasswordUseCase, this.validator)
    : super(ForgetPasswordState(baseState: BaseInitialState()));

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void doIntent(ForgetPasswordAction action) {
    switch (action) {
      case ForgetPasswordSendAction():
        {
          _sendForgetPasswordEmail(action.email);
        }
      case FormDataChangedAction():
        {
          _validateEmail();
        }
    }
  }

  Future<void> _sendForgetPasswordEmail(String email) async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(baseState: BaseLoadingState()));
      final result = await _forgetPasswordUseCase(
        ForgetPasswordRequestEntity(email: email),
      );
      switch (result) {
        case SuccessResult<ForgetPasswordResponseEntity>():
          {
            emit(state.copyWith(baseState: BaseSuccessState()));
          }
        case FailureResult<ForgetPasswordResponseEntity>():
          {
            emit(
              state.copyWith(
                baseState: BaseErrorState(
                  errorMessage: result.exception.toString(),
                  exception: result.exception,
                ),
              ),
            );
          }
      }
    }
  }

  void _validateEmail() {
    if (emailController.text.isNotEmpty && formKey.currentState!.validate()) {
      emit(state.copyWith(isValid: true));
    } else {
      emit(state.copyWith(isValid: false));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
