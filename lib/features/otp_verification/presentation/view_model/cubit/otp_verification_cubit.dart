import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/base/base_state.dart';
import '../../../../../core/utils/datasource_excution/api_result.dart';
import '../../../../../domain/auth/entity/forget_password/forget_password_request_entity.dart';
import '../../../../../domain/auth/entity/forget_password/forget_password_response_entity.dart';
import '../../../../../domain/auth/entity/otp_verification/request/otp_verification_request_entity.dart';
import '../../../../../domain/auth/entity/otp_verification/response/otp_verification_response_entity.dart';
import '../../../../../domain/auth/use_case/forget_password_use_case.dart';
import '../../../../../domain/auth/use_case/otp_verification_use_case.dart';

part 'otp_verification_state.dart';

@injectable
class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  final OtpVerificationUseCase _otpVerificationUseCase;
  final ForgetPasswordUseCase _forgetPasswordUseCase;

  OtpVerificationCubit(
    this._otpVerificationUseCase,
    this._forgetPasswordUseCase,
  ) : super(OtpVerificationState(baseState: BaseInitialState()));

  TextEditingController otpController = TextEditingController();
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Timer? timer;

  void doIntent(OtpVerificationAction action) {
    switch (action) {
      case OtpVerificationSendAction():
        {
          _verifyOtp();
        }
      case FormDataChangedAction():
        {
          _validateOtp();
        }
      case OtpVerificationResendAction():
        {
          _resendOtp();
        }
    }
  }

  Future<void> _verifyOtp() async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(baseState: BaseLoadingState()));
      var result = await _otpVerificationUseCase(
        OtpVerificationRequestEntity(resetCode: otpController.text),
      );
      switch (result) {
        case SuccessResult<OtpVerificationResponseEntity>():
          {
            emit(state.copyWith(baseState: BaseSuccessState()));
          }
        case FailureResult<OtpVerificationResponseEntity>():
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

  Future<void> _resendOtp() async {
    emit(state.copyWith(resendState: BaseLoadingState()));
    final result = await _forgetPasswordUseCase(
      ForgetPasswordRequestEntity(email: email.text),
    );
    switch (result) {
      case SuccessResult<ForgetPasswordResponseEntity>():
        {
          _startCountdown();
          emit(state.copyWith(resendState: BaseSuccessState()));
        }
      case FailureResult<ForgetPasswordResponseEntity>():
        {
          emit(
            state.copyWith(
              resendState: BaseErrorState(
                errorMessage: result.exception.toString(),
                exception: result.exception,
              ),
            ),
          );
        }
    }
  }

  void _startCountdown() {
    const totalSeconds = 60;
    timer?.cancel();
    emit(state.copyWith(secondsRemaining: totalSeconds));

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      final current = state.secondsRemaining;
      if (current! <= 1) {
        t.cancel();
        emit(state.copyWith(secondsRemaining: 0));
      } else {
        emit(state.copyWith(secondsRemaining: current - 1));
      }
    });
  }

  void _validateOtp() {
    if (otpController.text.isNotEmpty && formKey.currentState!.validate()) {
      emit(state.copyWith(isValid: true));
    } else {
      emit(state.copyWith(isValid: false));
    }
  }
}
