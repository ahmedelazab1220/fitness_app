import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/utils/shared_widgets/shared_auth_layout.dart';
import 'package:fitness_app/features/register/presentation/view/widgets/already_have_account_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/assets/app_icons.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/utils/shared_widgets/shared_blured_container.dart';
import '../../view_model/cubit/register_cubit.dart';

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
              TextFormField(
                controller: viewModel.passwordController,
                validator: (value) {
                  return viewModel.validator.validatePassword(value ?? "");
                },
                obscureText: true,
                decoration: InputDecoration(
                  hintText: LocaleKeys.Password.tr(),
                  prefixIcon: SvgPicture.asset(
                    AppIcons.lockLogo,
                    fit: BoxFit.scaleDown,
                  ),
                  suffixIcon: SvgPicture.asset(
                    AppIcons.eyeLogo,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  viewModel.doIntent(NextStepAction());
                },
                child: Text(LocaleKeys.Next.tr()),
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
