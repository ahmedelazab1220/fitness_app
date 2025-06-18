import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/cubit/login_cubit.dart';

class LoginButton extends StatelessWidget {
  final LoginCubit viewModel;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const LoginButton({
    required this.viewModel,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => context.read<LoginCubit>().doIntent(
          LoginRequestAction(
            email: emailController.text.trim(),
            password: passwordController.text,
            isFormValid: formKey.currentState?.validate() ?? false,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Text(
          LocaleKeys.Login.tr(),
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
