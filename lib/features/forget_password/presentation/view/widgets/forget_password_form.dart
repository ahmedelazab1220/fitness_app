import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/base/base_state.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/utils/shared_widgets/shared_auth_layout.dart';
import '../../../../../core/utils/shared_widgets/shared_blured_container.dart';
import '../../view_model/cubit/forget_password_cubit.dart';

class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<ForgetPasswordCubit>();
    return SharedAuthLayout(
      title: LocaleKeys.ForgotPassword.tr(),
      subtitle: LocaleKeys.EnterYourEmail.tr(),
      reverseOrder: true,
      child: SharedBluredContainer(
        child: Form(
          key: viewModel.formKey,
          onChanged: () => viewModel.doIntent(FormDataChangedAction()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: viewModel.emailController,
                validator: (value) =>
                    viewModel.validator.validateEmail(value ?? ''),
                decoration: InputDecoration(
                  hintText: LocaleKeys.Email.tr(),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: AppColors.white[AppColors.colorCode40],
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      if (state.isValid == true) {
                        viewModel.doIntent(
                          ForgetPasswordSendAction(
                            viewModel.emailController.text,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: state.isValid == true
                          ? AppColors.orange
                          : AppColors.white[AppColors.colorCode30],
                    ),
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
                        : Text(LocaleKeys.SendOTP.tr()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
