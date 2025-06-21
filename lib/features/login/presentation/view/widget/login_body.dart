
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/cubit/login_cubit.dart';
import 'dont_have_account.dart';
import 'forget_password.dart';
import 'login_button.dart';
import 'login_form.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    super.key,
    required this.viewModel,
  });

  final LoginCubit viewModel;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            LocaleKeys.Login.tr(),
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24),
          const LoginForm(),
          const SizedBox(height: 16),
          ForgotPasswordButton(viewModel),
          const SizedBox(height: 24),
          const LoginButton(),
          const SizedBox(height: 16),
          const DoNotHaveAccount(),
        ],
      ),
    );
  }
}