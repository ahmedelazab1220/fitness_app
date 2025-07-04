import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/assets/app_icons.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/utils/shared_widgets/shared_auth_layout.dart';
import '../../../../../core/utils/shared_widgets/shared_blured_container.dart';
import '../../view_model/cubit/login_cubit.dart';
import 'do_not_have_account.dart';
import 'forget_password.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<LoginCubit>();
    return SharedAuthLayout(
      title: LocaleKeys.WelcomeBack.tr(),
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
                  LocaleKeys.Login.tr(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
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
              const ForgotPasswordButton(),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  viewModel.doIntent(LoginRequestAction());
                },
                child: Text(LocaleKeys.Login.tr()),
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.center,
                child: DoNotHaveAccount(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
