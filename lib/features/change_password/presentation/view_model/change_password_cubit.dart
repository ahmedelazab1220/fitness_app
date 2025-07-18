import 'package:fitness_app/core/base/base_state.dart';
import 'package:fitness_app/domain/auth/entity/change_password/request/change_password_request_entity.dart';
import 'package:fitness_app/domain/auth/entity/change_password/response/change_password_response_entity.dart';
import 'package:fitness_app/domain/auth/use_case/change_password_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/datasource_excution/api_result.dart';
import 'change_password_state.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordCubit(this._changePasswordUseCase)
    : super(ChangePasswordState(changePasswordState: BaseInitialState()));

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  final ValueNotifier<bool> isOldPasswordVisible = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isNewPasswordVisible = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isConfirmNewPasswordVisible = ValueNotifier<bool>(
    false,
  );

  void doIntent(ChangePasswordAction action) {
    switch (action) {
      case UserChangePasswordAction():
        _changePassword();
    }
  }

  void _changePassword() async {
    emit(state.copyWith(changePasswordState: BaseLoadingState()));
    final result = await _changePasswordUseCase(
      ChangePasswordRequestEntity(
        oldPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
      ),
    );
    switch (result) {
      case SuccessResult<ChangePasswordResponseEntity>():
        emit(
          state.copyWith(
            changePasswordState: BaseSuccessState<ChangePasswordResponseEntity>(
              data: result.data,
            ),
          ),
        );
      case FailureResult<ChangePasswordResponseEntity>():
        emit(
          state.copyWith(
            changePasswordState: BaseErrorState(
              errorMessage: result.exception.toString(),
            ),
          ),
        );
    }
  }

  @override
  Future<void> close() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    return super.close();
  }
}
