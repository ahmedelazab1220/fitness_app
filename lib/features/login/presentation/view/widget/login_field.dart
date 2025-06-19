import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/cubit/login_cubit.dart';

class LoginFields extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final LoginCubit viewModel;

  const LoginFields(
    this.emailController,
    this.passwordController,

    this.viewModel, {
    super.key,
  });
  @override
  State<LoginFields> createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<LoginFields> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.emailController,
          validator: (value) =>
              widget.viewModel.validator.validateEmail(value ?? ""),
          style: const TextStyle(color: AppColors.white),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.email, color: AppColors.white),
            labelText: LocaleKeys.Email.tr(),
            hintText: LocaleKeys.EnterYourEmail.tr(),
            labelStyle: const TextStyle(color: AppColors.white),
            hintStyle: const TextStyle(color: AppColors.darkgrey),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.orange),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        TextFormField(
          controller: widget.passwordController,
          validator: (value) =>
              widget.viewModel.validator.validatePassword(value ?? ""),
          obscureText: _obscurePassword,
          style: const TextStyle(color: AppColors.white),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              color: AppColors.white,
            ),
            prefixIcon: const Icon(Icons.lock, color: AppColors.white),
            labelText: LocaleKeys.Password.tr(),
            hintText: LocaleKeys.EnterYourPassword.tr(),
            labelStyle: const TextStyle(color: AppColors.white),
            hintStyle: const TextStyle(color: AppColors.darkgrey),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.orange),
            ),
          ),
        ),
      ],
    );
  }
}
