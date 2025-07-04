import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/app_colors.dart';
import '../../../../core/base/base_state.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/di/di.dart';
import '../../../../core/utils/dialogs/app_toast.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../core/utils/routes/app_routes.dart';
import '../view_model/cubit/forget_password_cubit.dart';
import 'widgets/forget_password_form.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late final ForgetPasswordCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<ForgetPasswordCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state.baseState is BaseSuccessState) {
            showToast(
              title: LocaleKeys.SuccessSendOTPToYourEmail.tr(),
              color: AppColors.orange,
            );
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.otpVerificationRoute,
              arguments: {Constants.email: viewModel.emailController.text},
            );
          } else if (state.baseState is BaseErrorState) {
            showToast(
              title: (state.baseState as BaseErrorState).errorMessage,
              color: AppColors.red,
            );
          }
        },
        child: const Scaffold(body: ForgetPasswordForm()),
      ),
    );
  }
}
