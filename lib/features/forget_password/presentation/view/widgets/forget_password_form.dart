import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/assets/app_images.dart';
import '../../../../../core/base/base_state.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/cubit/forget_password_cubit.dart';

class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<ForgetPasswordCubit>();
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.backgroundTwo),
          fit: BoxFit.cover,
        ),
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 50.0),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.orange,
                        radius: 14,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            size: 28,
                            Icons.arrow_left_rounded,
                            color: AppColors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const Spacer(),
                      Image.asset(AppImages.appLogoImage),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 60.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      LocaleKeys.EnterYourEmail.tr(),
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.copyWith(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      LocaleKeys.ForgotPassword.tr(),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
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
                    onChanged: () =>
                        viewModel.doIntent(FormDataChangedAction()),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
