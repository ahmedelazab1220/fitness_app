import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/assets/app_images.dart';
import '../../../../../core/utils/di/di.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/utils/shared_widgets/blured_container.dart';
import '../../view_model/cubit/register_cubit.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegisterCubit>();
    return BluredContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.Register.tr(),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              TextFormField(
                controller: viewModel.firstNameController,
                validator: (value) =>
                    viewModel.validator.validateName(value ?? ""),
                decoration: InputDecoration(
                  labelText: LocaleKeys.FirstName.tr(),
                  labelStyle: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: AppColors.white),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SvgPicture.asset(
                      AppImages.userAvatar,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: viewModel.lastNameController,
                validator: (value) =>
                    viewModel.validator.validateName(value ?? ""),
                decoration: InputDecoration(
                  labelText: LocaleKeys.LastName.tr(),
                  labelStyle: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: AppColors.white),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SvgPicture.asset(
                      AppImages.userAvatar,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
                // Handle registration logic here
              },
              child: Text(LocaleKeys.Register.tr()),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
