import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/base/base_state.dart';
import '../../../../../core/utils/dialogs/app_toast.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/cubit/otp_verification_cubit.dart';

class ResendOtpVerification extends StatelessWidget {
  const ResendOtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpVerificationCubit, OtpVerificationState>(
      buildWhen: (previous, current) =>
          previous.secondsRemaining != current.secondsRemaining ||
          previous.resendState != current.resendState,
      listener: (context, state) {
        if (state.resendState is BaseErrorState) {
          showToast(
            title: (state.resendState as BaseErrorState).errorMessage,
            color: AppColors.red,
          );
        }
      },
      builder: (context, state) {
        if (state.secondsRemaining! > 0) {
          return Align(
            alignment: Alignment.center,
            child: Text(
              '${LocaleKeys.ResendIn.tr()} ${state.secondsRemaining}s',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return TextButton(
          onPressed: () {
            context.read<OtpVerificationCubit>().doIntent(
              OtpVerificationResendAction(),
            );
          },
          child: state.resendState is BaseLoadingState
              ? const SizedBox(
                  height: 10,
                  width: 10,
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.white),
                  ),
                )
              : Text(
                  LocaleKeys.ResendCode.tr(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.orange,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.orange,
                    decorationThickness: 1.5,
                  ),
                ),
        );
      },
    );
  }
}
