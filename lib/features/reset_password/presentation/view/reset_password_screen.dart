import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/app_colors.dart';
import '../../../../core/base/base_state.dart';
import '../../../../core/utils/di/di.dart';
import '../../../../core/utils/dialogs/app_toast.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../core/utils/routes/app_routes.dart';
import '../view_model/cubit/reset_password_cubit.dart';
import 'reset_password_body.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late final ResetPasswordCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<ResetPasswordCubit>();
    viewModel.emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocListener<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state.baseState is BaseSuccessState) {
            showToast(
              title: LocaleKeys.ResetPasswordSuccessfully.tr(),
              color: AppColors.orange,
            );
            Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
          }
          if (state.baseState is BaseErrorState) {
            showToast(
              title: (state.baseState as BaseErrorState).errorMessage,
              color: AppColors.red,
            );
          }
        },
        child: const Scaffold(body: ResetPasswordBody()),
      ),
    );
  }
}
