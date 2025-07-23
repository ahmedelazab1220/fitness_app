import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/features/change_password/presentation/view_model/change_password_cubit.dart';
import 'package:fitness_app/features/change_password/presentation/view_model/change_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/assets/app_icons.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/utils/shared_widgets/shared_blured_container.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ChangePasswordCubit>();
    return SharedBluredContainer(
      child: Form(
        key: viewModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            ValueListenableBuilder(
              valueListenable: viewModel.isOldPasswordVisible,
              builder: (BuildContext context, value, Widget? child) {
                return TextFormField(
                  controller: viewModel.oldPasswordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return viewModel.validator.validatePassword(value ?? "");
                  },
                  obscureText: !value,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.OldPassword.tr(),
                    prefixIcon: SvgPicture.asset(
                      AppIcons.lockLogo,
                      fit: BoxFit.scaleDown,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        viewModel.isOldPasswordVisible.value =
                            !viewModel.isOldPasswordVisible.value;
                      },
                      icon: SvgPicture.asset(
                        viewModel.isOldPasswordVisible.value
                            ? AppIcons.eyeLogo
                            : AppIcons.eyeSlashLogo,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: viewModel.isNewPasswordVisible,
              builder: (BuildContext context, value, Widget? child) {
                return TextFormField(
                  controller: viewModel.newPasswordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return viewModel.validator.validatePassword(value ?? "");
                  },
                  obscureText: !value,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.NewPassword.tr(),
                    prefixIcon: SvgPicture.asset(
                      AppIcons.lockLogo,
                      fit: BoxFit.scaleDown,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        viewModel.isNewPasswordVisible.value =
                            !viewModel.isNewPasswordVisible.value;
                      },
                      icon: SvgPicture.asset(
                        viewModel.isNewPasswordVisible.value
                            ? AppIcons.eyeLogo
                            : AppIcons.eyeSlashLogo,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: viewModel.isConfirmNewPasswordVisible,
              builder: (BuildContext context, value, Widget? child) {
                return TextFormField(
                  controller: viewModel.confirmNewPasswordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return viewModel.validator.validateConfirmPassword(
                      viewModel.newPasswordController.text,
                      viewModel.confirmNewPasswordController.text,
                    );
                  },
                  obscureText: !value,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.ConfirmNewPassword.tr(),
                    prefixIcon: SvgPicture.asset(
                      AppIcons.lockLogo,
                      fit: BoxFit.scaleDown,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        viewModel.isConfirmNewPasswordVisible.value =
                            !viewModel.isConfirmNewPasswordVisible.value;
                      },
                      icon: SvgPicture.asset(
                        viewModel.isConfirmNewPasswordVisible.value
                            ? AppIcons.eyeLogo
                            : AppIcons.eyeSlashLogo,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                viewModel.doIntent(UserChangePasswordAction());
              },
              child: Text(LocaleKeys.ChangePassword.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
