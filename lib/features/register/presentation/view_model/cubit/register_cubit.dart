import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/base/base_state.dart';
import 'package:fitness_app/core/utils/validator/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/utils/datasource_excution/api_result.dart';
import '../../../../../data/auth/models/request/register_request_dto.dart';
import '../../../../../data/auth/models/response/register_response_dto.dart';
import '../../../../../domain/auth/use_case/register_use_case.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;
  final Validator validator;
  RegisterCubit(this._registerUseCase, this.validator)
    : super(RegisterState(registerState: BaseInitialState()));

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  void doIntent(RegisterAction action) {
    switch (action) {
      case UserRegistrationAction():
        {
          _register();
        }
    }
  }

  void _register() async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(registerState: BaseLoadingState()));
      final request = RegisterRequestDto(
        email: emailController.text,
        password: passwordController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        rePassword: passwordController.text,
      );
      final result = await _registerUseCase((request));

      switch (result) {
        case SuccessResult<RegisterResponseDto>():
          {
            emit(
              state.copyWith(
                registerState: BaseSuccessState<RegisterResponseDto>(
                  data: result.data,
                ),
              ),
            );
          }
        case FailureResult<RegisterResponseDto>():
          {
            emit(
              state.copyWith(
                registerState: BaseErrorState(
                  errorMessage: result.exception.toString(),
                ),
              ),
            );
          }
      }
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    return super.close();
  }
}
