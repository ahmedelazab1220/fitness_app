import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/assets/app_images.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/utils/shared_widgets/blured_container.dart';
import '../../view_model/cubit/login_cubit.dart';
import 'donot_have_account.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<LoginCubit>();
    return BluredContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.Login.tr(),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              TextFormField(
                controller: viewModel.emailController,
                validator: (value) =>
                    viewModel.validator.validateEmail(value ?? ""),
                decoration: InputDecoration(
                  labelText: LocaleKeys.Email.tr(),
                  labelStyle: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: AppColors.white),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SvgPicture.asset(
                      AppImages.mailLogo,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: viewModel.passwordController,
                validator: (value) =>
                    viewModel.validator.validatePassword(value ?? ""),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: LocaleKeys.Password.tr(),
                  labelStyle: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: AppColors.white),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SvgPicture.asset(
                      AppImages.lockLogo,
                      width: 24,
                      height: 24,
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SvgPicture.asset(
                      AppImages.eyeLogo,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                viewModel.doIntent(LoginRequestAction());
              },
              child: Text(LocaleKeys.Login.tr()),
            ),
          ),
          const SizedBox(height: 16),
          const DonotHaveAccount(),
        ],
      ),
    );
  }
}
