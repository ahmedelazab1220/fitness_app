import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/utils/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/assets/app_colors.dart';
import '../../../../core/assets/app_icons.dart';
import '../../../../core/assets/app_images.dart';
import '../../../../core/base/base_state.dart';
import '../../../../core/utils/dialogs/app_dialogs.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../core/utils/routes/app_routes.dart';
import '../view_model/cubit/login_cubit.dart';
import 'widget/login_body.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final viewModel = getIt<LoginCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is BaseLoadingState) {
            AppDialogs.showLoadingDialog(context);
          } else if (state is BaseSuccessState) {
            AppDialogs.hideLoading(context);
            Navigator.pushReplacementNamed(context, AppRoutes.mainLayoutRoute);
          } else if (state is BaseErrorState) {
            AppDialogs.hideLoading(context);
            AppDialogs.showFailureDialog(
              context,
              message: (state.baseState as BaseErrorState).errorMessage,
            );
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
                          LoginBody(viewModel: viewModel),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
