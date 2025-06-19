import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/assets/app_colors.dart';
import '../../../../core/assets/app_icons.dart';
import '../../../../core/assets/app_images.dart';
import '../../../../core/base/base_state.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';
import '../view_model/cubit/login_cubit.dart';
import 'widget/dont_have_account.dart';
import 'widget/forget_password.dart';
import 'widget/login_button.dart';
import 'widget/login_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<LoginCubit>();
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        final baseState = state.baseState;
        if (baseState is BaseNavigationState) {
          switch (baseState.type) {
            case NavigationType.push:
              Navigator.pushNamed(context, baseState.routeName);
              break;
            case NavigationType.pushReplacement:
              Navigator.pushReplacementNamed(context, baseState.routeName);
              break;
            case NavigationType.pop:
              Navigator.pop(context);
              break;
          }
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              child: Image.asset(
                AppImages.backgroundTwo,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(50.0.r),
                          child: SvgPicture.asset(
                            AppIcons.loginLogo,
                            height: 100.h,
                            width: 100.w,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(18.0.r),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${LocaleKeys.HeyThere.tr()}\n${LocaleKeys.WelcomeBack.tr()}',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(24.r),
                          decoration: BoxDecoration(
                            // ignore: deprecated_member_use
                            color: AppColors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: Form(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  LocaleKeys.Login.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                SizedBox(height: 24.h),
                                LoginFields(
                                  emailController,
                                  passwordController,
                                  viewModel,
                                ),
                                SizedBox(height: 16.h),
                                ForgotPasswordButton(viewModel),
                                SizedBox(height: 24.h),
                                LoginButton(
                                  viewModel: viewModel,
                                  emailController: emailController,
                                  passwordController: passwordController,
                                ),
                                SizedBox(height: 16.h),
                                DoNotHaveAccount(viewModel),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
