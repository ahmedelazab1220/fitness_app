import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/base/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/app_colors.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';
import '../view_model/cubit/reset_password_cubit.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<ResetPasswordCubit>();
    return SliverToBoxAdapter(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: AnimatedContainer(
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 32.0,
            ),
            color: AppColors.darkgrey.withAlpha(150),
            duration: const Duration(milliseconds: 3000),
            child: Form(
              key: viewModel.formKey,
              onChanged: () => viewModel.doIntent(FormDataChangedAction()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                    builder: (context, state) {
                      return TextFormField(
                        controller: viewModel.newPasswordController,
                        obscureText: !state.isNewPasswordVisible,
                        validator: (value) =>
                            viewModel.validator.validatePassword(value ?? ''),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              state.isNewPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () => viewModel.doIntent(
                              ToggleNewPasswordVisibility(),
                            ),
                          ),
                          hint: Text(LocaleKeys.Password.tr()),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24.0),
                  BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                    builder: (context, state) {
                      return TextFormField(
                        controller: viewModel.confirmPasswordController,
                        obscureText: !state.isConfirmPasswordVisible,
                        validator: (value) =>
                            viewModel.validator.validateConfirmPassword(
                              value ?? '',
                              viewModel.newPasswordController.text,
                            ),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              state.isConfirmPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () => viewModel.doIntent(
                              ToggleConfirmPasswordVisibility(),
                            ),
                          ),
                          hint: Text(LocaleKeys.ConfirmPassword.tr()),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24.0),
                  BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          viewModel.doIntent(ResetPasswordSendAction());
                        },
                        child: state.baseState is BaseLoadingState
                            ? const SizedBox(
                                width: 10,
                                height: 10,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.white,
                                  ),
                                ),
                              )
                            : Text(LocaleKeys.Done.tr()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
