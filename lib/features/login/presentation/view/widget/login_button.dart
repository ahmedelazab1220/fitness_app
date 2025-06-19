import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/cubit/login_cubit.dart';

class LoginButton extends StatelessWidget {
  final LoginCubit viewModel;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    required this.viewModel,
    required this.emailController,
    required this.passwordController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final formState = Form.of(context);
          if (formState.validate()) {
            context.read<LoginCubit>().doIntent(
              LoginRequestAction(
                email: emailController.text.trim(),
                isFormValid:
                    emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty,
                password: passwordController.text.trim(),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.orange,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
        ),
        child: Text(
          LocaleKeys.Login.tr(),
          style: TextStyle(fontSize: 16.sp, color: AppColors.white),
        ),
      ),
    );
  }
}
