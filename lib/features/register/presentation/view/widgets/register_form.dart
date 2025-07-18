import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/assets/app_icons.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/utils/shared_widgets/shared_auth_layout.dart';
import '../../../../../core/utils/shared_widgets/shared_blured_container.dart';
import '../../view_model/cubit/register_cubit.dart';
import 'already_have_account_text.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegisterCubit>();
    return SharedAuthLayout(
      title: LocaleKeys.CreateAnAccount.tr(),
      subtitle: LocaleKeys.HeyThere.tr(),
      setBackButton: false,
      reverseOrder: true,
      child: SharedBluredContainer(
        child: Form(
          onChanged: () => viewModel.doIntent(FormDataChangedAction()),
          key: viewModel.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  LocaleKeys.Register.tr(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: viewModel.firstNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return viewModel.validator.validateName(value ?? "");
                },
                decoration: InputDecoration(
                  hintText: LocaleKeys.FirstName.tr(),
                  prefixIcon: SvgPicture.asset(
                    AppIcons.userIcon,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: viewModel.lastNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return viewModel.validator.validateName(value ?? "");
                },
                decoration: InputDecoration(
                  hintText: LocaleKeys.LastName.tr(),
                  prefixIcon: SvgPicture.asset(
                    AppIcons.userIcon,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: viewModel.emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,

                validator: (value) {
                  return viewModel.validator.validateEmail(value ?? "");
                },
                decoration: InputDecoration(
                  hintText: LocaleKeys.Email.tr(),
                  prefixIcon: SvgPicture.asset(
                    AppIcons.mailLogo,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ValueListenableBuilder(
                valueListenable: viewModel.isPasswordVisible,
                builder: (context, value, child) {
                  return TextFormField(
                    controller: viewModel.passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,

                    validator: (value) {
                      return viewModel.validator.validatePassword(value ?? "");
                    },
                    obscureText: !value,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.Password.tr(),
                      prefixIcon: SvgPicture.asset(
                        AppIcons.lockLogo,
                        fit: BoxFit.scaleDown,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          viewModel.isPasswordVisible.value =
                              !viewModel.isPasswordVisible.value;
                        },
                        icon: SvgPicture.asset(
                          viewModel.isPasswordVisible.value
                              ? AppIcons.eyeLogo
                              : AppIcons.eyeSlashLogo,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              ValueListenableBuilder(
                valueListenable: viewModel.isValidate,
                builder: (context, value, child) {
                  return ElevatedButton(
                    onPressed: value
                        ? () {
                            viewModel.doIntent(NextStepAction());
                          }
                        : null,
                    style: Theme.of(context).elevatedButtonTheme.style
                        ?.copyWith(
                          backgroundColor: WidgetStateProperty.all(
                            value
                                ? AppColors.orange
                                : AppColors.white[AppColors.colorCode30],
                          ),
                        ),
                    child: Text(LocaleKeys.Next.tr()),
                  );
                },
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.center,
                child: AlreadyHaveAccountText(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
